import 'package:alero/models/customer/CustomerDetailsResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/components/empty_list_item.dart';
import 'package:alero/screens/alero/customer/customer_accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/flutter_shimmer_loading_widget.dart';
import '../../../style/theme.dart' as Style;
import 'package:async/async.dart';

class ViewAllAccounts extends StatefulWidget {
  final String groupId;
  final Function(String accountNo) setAccount;

  ViewAllAccounts(this.groupId, {@required this.setAccount});

  @override
  State<ViewAllAccounts> createState() => _ViewAllAccountsState();
}

class _ViewAllAccountsState extends State<ViewAllAccounts> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var apiService = AleroAPIService();
  String customerName = " ", customerGender = " ", customerType = " ";
  CustomerDetailsResponse customerDetailsResponse;
  List<Widget> accountsItem = [];
  String selectedAccount;
  String groupId;
  int index = 0;

  @override
  void initState() {
    super.initState();
    getCustomerDetails(widget.groupId);
    getBankingData(widget.groupId);
  }

  Future getBankingData(String customerId) async {
    final accountData = await apiService.getBankingData(customerId);
    List<Widget> _accountsItem = [];
    if (accountData.length == 0) {
      _accountsItem.add(EmptyListItem(message: 'No Customer Accounts'));
    } else {
      for(int i =0; i < accountData.length; i++) {
        _accountsItem.add(
          GestureDetector(
            onTap: () {
              setState(() {
                selectedAccount = accountData[i]['accountNumber'];
                widget.setAccount(accountData[i]['accountNumber']);
              });
              Navigator.pop(context);
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.view_list),
                          iconSize: 25.0,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Text(
                              accountData[i]["accountClassName"],
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: 250,
                              child: Text(
                                accountData[i]["accountNumber"],
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal),
                              )),
                        ],
                      ),
                    ],
                  ),
                  Divider(thickness: 2),
                ],
              ),
            ),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        accountsItem = _accountsItem;
      });
    }
    return accountData;
  }

  Future getCustomerDetails(String groupId) async {
    print(groupId);
    return this._memoizer.runOnce(() async {
      final customerDetails = await apiService.getCustomerDetails(groupId);
      print(customerDetails);
      updateCustomerDetails(customerDetails);
      return customerDetails;
    });
  }

  void updateCustomerDetails(CustomerDetailsResponse customerDetails) {
    if (mounted) {
      setState(() {
        customerName = customerDetails.customerName;
        customerGender = customerDetails.customerGender;
        customerType = customerDetails.customerType;
        customerDetailsResponse = customerDetails;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return FlutterShimmnerLoadingWidget(
            count: 2,
            animate: true,
            color: Colors.grey[200],
          );
        }
        return Container(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0),
            child: Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 8),
                    child: Text(
                      selectedAccount ?? 'All Accounts',
                      style: TextStyle(color: Style.Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Style.Colors.buttonColor,
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 8),
                        child: Text(
                          'View Accounts',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Poppins-Regular',
                              fontWeight: FontWeight.normal),
                        )),
                    decoration: BoxDecoration(
                      border: Border.all(color: Style.Colors.buttonColor),
                      color: Style.Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      future: getCustomerDetails(widget.groupId),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return AccountListDialog(accountsItem, widget.groupId);
      },
    );
  }
}

class AccountListDialog extends StatefulWidget {
  final List accountsItem;
  final String groupId;

  AccountListDialog(this.accountsItem, this.groupId);

  @override
  State<AccountListDialog> createState() => _AccountListDialogState();
}

class _AccountListDialogState extends State<AccountListDialog> {
  bool loaded;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 160.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Align(
        alignment: Alignment.topRight,
        child: CircleAvatar(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close_outlined),
            iconSize: 25.0,
            color: Colors.white70,
          ),
        ),
      ),
      content: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CustomerAccounts(groupId: widget.groupId)));
              },
              child: Row(
                children: [
                  CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.view_list),
                        iconSize: 25.0,
                        color: Colors.white70,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('All Accounts',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Poppins-Regular',
                              fontWeight: FontWeight.normal)),
                      Text('Savings/Current',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Poppins-Regular',
                              fontWeight: FontWeight.normal)),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.accountsItem.length,
                  itemBuilder: (context, index) {
                    return widget.accountsItem[index];
                  }),
            ),
          ],
        ),
      ),
      actions: [],
    );
  }
}
