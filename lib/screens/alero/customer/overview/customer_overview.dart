

import 'package:alero/models/customer/ComplaintFLow.dart';
import 'package:alero/screens/alero/components/accounts_body_list.dart';
import 'package:alero/screens/alero/components/complaints_caregories_card.dart';
import 'package:alero/screens/alero/components/complaints_trend_card.dart';
import 'package:alero/screens/alero/components/customer_complaint_list.dart';
import 'package:alero/screens/alero/components/investments_body_list.dart';
import 'package:alero/screens/alero/components/loans_body_list.dart';
import 'package:alero/screens/alero/components/next_best_offering_body.dart';
import 'package:alero/screens/alero/components/post_no_debit_body_list.dart';
import 'package:alero/screens/alero/components/value_chain_body_list.dart';
import 'package:alero/screens/alero/components/trade_transactions_body_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import '../../../../models/customer/CustomerDetailsResponse.dart';
import '../../../../models/response/AccountList.dart';
import '../../../../models/response/CardList.dart';
import '../../../../network/AleroAPIService.dart';
import '../../../../style/theme.dart' as Style;
import '../../../../utils/Pandora.dart';
import 'package:async/async.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';
import '../../components/empty_list_item.dart';
import '../../components/overview_accounts_item.dart';
import '../../components/overview_channels_card_item.dart';
import '../../components/overview_echannels_list_item.dart';
import '../../components/overview_grid_item.dart';
import '../../search/shimmer_loading_widget.dart';

class CustomerOverview extends StatefulWidget {
  final CustomerDetailsResponse? customerDetails;
  final String? customerAccountNo;
  final int? index;

  CustomerOverview({Key? key, required this.customerDetails, this.customerAccountNo, this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    GetIt.I<FirebaseAnalytics>()
        .setCurrentScreen(screenName: 'Customer Overview Page');
    return _CustomerOverviewState();
  }
}

class _CustomerOverviewState extends State<CustomerOverview> {
  final formatCurrency = new NumberFormat.currency(symbol: "");
  final Pandora pandora = new Pandora();
  var apiService = AleroAPIService();
  var data;
  bool loading = true;
  bool hasComplaints = false;

  String? customerId = "", groupId = "";
  double? ytdRevenue = 0;

  int _current = 0;
  final AsyncMemoizer _accountMem = AsyncMemoizer();
  final AsyncMemoizer _revenue = AsyncMemoizer();
  final AsyncMemoizer _channels = AsyncMemoizer();
  final AsyncMemoizer _cards = AsyncMemoizer();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  List<Widget> channels = [];
  List<CardList> cardsList = [];
  List<AccountList> accountList = [];
  List<ComplaintFlow> cfData = [];
  int transactionCount = 0;
  bool hasAccountData = false;
  bool hasCards = false;

  void getCustomerDetails() {
    if (mounted) {
      setState(() {
        customerId = data.customerId;
        groupId = data.groupId;
      });
    }
    getCustomerBankingData(data.groupId);
    getCustomerRevenueData(data.groupId);
    getChannelData(data.groupId);
    getDebitCardData(data.groupId);
    getComplaintTrend(data.groupId);
  }

  void loadData() async {
    if (data == null) {
      data = widget.customerDetails;
      await Future.delayed(const Duration(seconds: 2), () {
        loadData();
      });
    } else {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future getCustomerBankingData(String? groupId) async {
    return this._accountMem.runOnce(() async {
      final bankingData = await apiService.getBankingData(groupId!);
      if (bankingData.isEmpty) {
        if (mounted) {
          setState(() {
            hasAccountData = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            hasAccountData = true;
          });
        }
        accountList = [];
        bankingData.forEach((account) {
          accountList.add(AccountList(
              accountType: account["accountClassName"],
              accountNumber: account["accountNumber"],
              createdAddress: account["branchName"],
              createdDate: "Opened ${account["acctOpeningDate"]}",
              balance: account["ccyBalance"],
              active: account["activeStatus"],
              currency: account["currency"]));
        });
      }
      return bankingData;
    });
  }

  Future getCustomerRevenueData(String? groupId) async {
    return this._revenue.runOnce(() async {
      final revenueData = widget.customerAccountNo == null
          ? await apiService.getRevenueData(groupId!)
          : await apiService.getRevenueAccountData(widget.customerAccountNo!);
      if (mounted) {
        setState(() {
          ytdRevenue = revenueData.ytdRevenue;
        });
      }
      return revenueData;
    });
  }

  Future getChannelData(String? groupId) async {
    return this._channels.runOnce(() async {
      final channelsData = widget.customerAccountNo == null
          ? await apiService.getChannelsData(groupId!)
          : await apiService.getChannelsDataWithAccountNo(widget.customerAccountNo!);
      List<Widget> channelItem = [];
      if (channelsData.length == 0) {
        channelItem.add(EmptyListItem(message: 'No Channels Data Found'));
      } else {
        channelsData.forEach((channel) {
          channelItem.add(
            OverviewEchannelsListItem(
              channelName: channel["channelName"] ?? channel["channel"],
              dateEnrolled: channel["enrolmentDate"],
              active: (channel["channelStatus"] == 'Active') ? true : false,
            ),
          );
        });
      }
      if (mounted) {
        setState(() {
          channels = channelItem;
        });
      }
      return channelsData;
    });
  }

  Future getDebitCardData(String? groupId) async {
    return this._cards.runOnce(() async {
      final cardData = await apiService.getDebitCardData(groupId!);
      cardsList = [];
      if (cardData.length == 0) {
        if (mounted) {
          setState(() {
            hasCards = false;
          });
        }
        cardsList.add(CardList(
          cardPan: "No Cards Available",
          cardType: "No Card Data",
        ));
      } else {
        if (mounted) {
          setState(() {
            hasCards = true;
          });
        }
        cardData.forEach((card) {
          cardsList.add(CardList(
            cardPan: card["expiryDate"],
            cardType: card["channelType"],
          ));
        });
      }
      return cardData;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        color: Style.Colors.tabBackGround,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CardPlaceHolderWithImage(
                              height: 200,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: FlutterShimmnerLoadingWidget(
                                count: 2,
                                animate: true,
                                color: Colors.grey[200],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CardPlaceHolderWithImage(
                              height: 200,
                            ),
                            SimpleTextPlaceholder(),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    }
    getCustomerDetails();
    return Container(
      color: Style.Colors.tabBackGround,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        loadAccountsCarousel(),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 29),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              loadRevenueData(),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.grey.shade50,
                                      blurRadius: 0.5,
                                    ),
                                  ],
                                ),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            OverviewGrid(
                                              text: 'Accounts',
                                              image:
                                              'assets/customer/overview/overview_accounts.svg',
                                              press: () {
                                                loadDialogs(
                                                    NextBestOfferingBody(
                                                        title: "Accounts",
                                                        customerId: customerId,
                                                        groupId: groupId,
                                                        listBody:
                                                        AccountsBodyList(
                                                          customerId:
                                                          customerId,
                                                          groupId: groupId,
                                                        )));
                                              },
                                            ),
                                            OverviewGrid(
                                              customerAccountNo: widget.customerAccountNo,
                                              text: 'Channels',
                                              image:
                                              'assets/customer/overview/overview_channels.svg',
                                              press: () {
                                                loadChannelsDialog();
                                              },
                                            ),
                                            OverviewGrid(
                                              customerAccountNo: widget.customerAccountNo,
                                              text: 'Investments',
                                              image:
                                              'assets/customer/overview/overview_investments.svg',
                                              press: () {
                                                loadDialogs(
                                                    NextBestOfferingBody(
                                                        title: "Investments",
                                                        customerId: customerId,
                                                        groupId: groupId,
                                                        customerAccountNo: widget.customerAccountNo,
                                                        listBody: InvestmentsBodyList(
                                                          customerId: customerId,
                                                          groupId: groupId,
                                                          customerAccountNo: widget.customerAccountNo,
                                                        )));
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            OverviewGrid(
                                              customerAccountNo: widget.customerAccountNo,
                                              text: 'Loans',
                                              image: 'assets/customer/overview/overview_loans.svg',
                                              press: () {
                                                loadDialogs(
                                                    NextBestOfferingBody(
                                                        title: "Loans",
                                                        customerId: customerId,
                                                        groupId: groupId,
                                                        customerAccountNo: widget.customerAccountNo,
                                                        listBody: LoansBodyList(
                                                          customerId: customerId,
                                                          groupId: groupId,
                                                          customerAccountNo: widget.customerAccountNo,
                                                        )));
                                              },
                                            ),
                                            OverviewGrid(
                                              customerAccountNo: widget.customerAccountNo,
                                              text: 'Value Chain',
                                              image:
                                              'assets/customer/overview/overview_value_chain.svg',
                                              press: () {
                                                loadDialogs(
                                                    NextBestOfferingBody(
                                                        title: "Value Chain",
                                                        customerId: customerId,
                                                        groupId: groupId,
                                                        customerAccountNo: widget.customerAccountNo,
                                                        listBody: ValueChainBodyList(
                                                          customerId: customerId,
                                                          groupId: groupId,
                                                        )));
                                              },
                                            ),
                                            OverviewGrid(
                                              customerAccountNo: widget.customerAccountNo,
                                              text: 'PND',
                                              image: 'assets/customer/overview/overview_pnd.svg',
                                              press: () {
                                                loadDialogs(
                                                    NextBestOfferingBody(
                                                        title:
                                                        "Post No Debit (PND)",
                                                        customerId: customerId,
                                                        groupId: groupId,
                                                        customerAccountNo: widget.customerAccountNo,
                                                        listBody:
                                                        PostNoDebitBodyList(
                                                          customerId: customerId,
                                                          groupId: groupId,
                                                          customerAccountNo: widget.customerAccountNo,
                                                        )));
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            OverviewGrid(
                                              customerAccountNo: widget.customerAccountNo,
                                              text: 'Trade Transactions',
                                              image:
                                              'assets/icons/shopping_bag.svg',
                                              press: () {
                                                loadDialogs(
                                                    NextBestOfferingBody(
                                                        title: "Trade Transactions",
                                                        customerId: customerId,
                                                        groupId: groupId,
                                                        customerAccountNo: widget.customerAccountNo,
                                                        listBody: TradeTransactionsBodyList(
                                                          customerId: customerId,
                                                          groupId: groupId,
                                                          customerAccountNo: widget.customerAccountNo,
                                                        )));
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              loadComplaintsInformation()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loadComplaintsInformation() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Complaints Management',
              style: TextStyle(
                color: Style.Colors.buttonColor,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Bold',
              )),
        ),
        SizedBox(
          height: 20,
        ),
        customerComplaintsCharts(),
        SizedBox(
          height: 8,
        ),
        CustomerComplaintsList(customerId: customerId, groupId: groupId)
      ],
    );
  }

  Future getComplaintTrend(String? groupId) async {
    return this._asyncMemoizer.runOnce(() async {
      var flow = await apiService.getCustomerComplaints(groupId!);
      if (flow.length > 0) {
        if (mounted) {
          setState(() {
            hasComplaints = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            hasComplaints = false;
          });
        }
      }
    });
  }

  Widget customerComplaintsCharts() {
    print(hasComplaints);
    return FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            return CardPlaceHolderWithAvatar();
          }
          return Visibility(
              visible: hasComplaints,
              child: Column(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 261,
                            height: 222,
                            margin: EdgeInsets.only(right: 20, left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey.shade50,
                                  blurRadius: 0.5,
                                ),
                              ],
                            ),
                            child: ComplaintsTrendCard(
                              customerId: customerId,
                              groupId: groupId,
                            ),
                          ),
                          Container(
                            width: 261,
                            height: 222,
                            margin: EdgeInsets.only(right: 20, left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey.shade50,
                                  blurRadius: 0.5,
                                ),
                              ],
                            ),
                            child: ComplaintsCartegoriesCard(
                              customerId: customerId,
                              groupId: groupId,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('All Complaints',
                        style: TextStyle(
                          color: Style.Colors.buttonColor,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Bold',
                        )),
                  ),],
              ));},
        future: getComplaintTrend(groupId));
  }

  Widget loadAccountsCarousel() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: FlutterShimmnerLoadingWidget(
              count: 2,
              animate: true,
              color: Colors.grey[200],
            ),
          );
        }
        if (hasAccountData) {
          return widget.customerAccountNo == null ?
          Column(
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                      height: 125.0,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      viewportFraction: 0.85,
                      enableInfiniteScroll: false,
                      scrollPhysics: BouncingScrollPhysics(),
                      onPageChanged: (index, reason) {
                        if (mounted) {
                          setState(() {
                            _current = index;
                          });
                        }
                      }),
                  items: accountList.map((accountList) {
                    return Builder(
                      builder: (BuildContext context) {
                        return AccountsCardItem(
                          accountNumber: accountList.accountNumber,
                          accountType: accountList.accountType,
                          amount: accountList.balance,
                          currency: accountList.currency,
                        );
                      },
                    );
                  }).toList()
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: accountList.map((url) {
                  int index = accountList.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Style.Colors.buttonColor
                          : Style.Colors.overviewTextGrey,
                    ),
                  );
                }).toList(),
              )
            ],
          )
              : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
            child: AccountsCardItem(
              accountNumber: accountList[0].accountNumber,
              accountType: accountList[0].accountType,
              amount: accountList[0].balance,
              currency: accountList[0].currency,
            ),
          );
        } else {
          return EmptyListItem(
            message: 'No Account Information',
          );
        }},
      future: getCustomerBankingData(groupId),
    );
  }

  Widget loadCardsCarousel() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null ||
            projectSnap.connectionState == ConnectionState.waiting) {
          return FlutterShimmnerLoadingWidget(
            count: 2,
            animate: true,
            color: Colors.grey[200],
          );
        }
        if (hasCards) {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 125.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    onPageChanged: (index, reason) {
                      if (mounted) {
                        setState(() {
                          _current = index;
                        });
                      }
                    }),
                items: cardsList.map((cardList) {
                  return Builder(
                    builder: (BuildContext context) {
                      return OverviewChannelsCardItem(
                        cardPan: cardList.cardPan,
                        cardType: cardList.cardType,
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cardsList.map((url) {
                  int index = cardsList.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Style.Colors.buttonColor
                          : Style.Colors.overviewTextGrey,
                    ),
                  );
                }).toList(),
              )
            ],
          );
        } else {
          return EmptyListItem(
            message: 'Customer has no Cards',
          );
        }
      },
      future: getDebitCardData(groupId),
    );
  }

  Widget loadRevenueData() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return ShimmerLoadingWidget();
        }
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('YTD REVENUE',
                  style: TextStyle(
                    color: Style.Colors.buttonColor,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins-Bold',
                  )),
            ),
            SizedBox(
              height: 4,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("N " + formatCurrency.format(ytdRevenue),
                  softWrap: true,
                  style: TextStyle(
                    color: Style.Colors.blackTextColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins-Bold',
                  )),
            ),
          ],
        );
      },
      future: getCustomerRevenueData(groupId),
    );
  }

  Widget loadChannelsData() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoadingWidget();
        }
        return Expanded(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: channels.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                            alignment: Alignment.topCenter,
                            child: channels[index]);
                      }),],
              )),
        );
      },
      future: getChannelData(groupId),
    );
  }

  void loadChannelsDialog() {
    OneContext().showBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      builder: (context) => Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0)),
            color: Colors.white,
          ),
          height: 510,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                          children: [
                            Text('Channels | ',
                                style: TextStyle(
                                  color: Style.Colors.blackTextColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold',
                                )),
                            Text('Cards',
                                style: TextStyle(
                                  color: Style.Colors.buttonColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins-Bold',
                                )),
                          ],
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          'assets/customer/dialog_close_button.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                loadCardsCarousel(),
                SizedBox(
                  height: 12,
                ),
                loadChannelsData()
              ],
            ),
          ) // or OneContext().popDialog('sucess');
      ),
    );
  }

  void loadDialogs(Widget widget) {
    OneContext().showBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      builder: (context) => Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          color: Colors.white,
        ),
        height: 510,
        child: widget,
      ),
    );
  }
}
