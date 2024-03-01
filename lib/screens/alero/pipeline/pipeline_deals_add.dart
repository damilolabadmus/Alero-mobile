import 'dart:collection';
import 'package:alero/models/call/ProductTypeDetailsResponse.dart';
import 'package:alero/models/call/ProspectDetailsResponse.dart';
import 'package:alero/models/call/RevenueDetailsResponse.dart';
import 'package:alero/models/search/SearchUserResponse.dart';
import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/call/call_bottom_navigation_bar.dart';
import 'package:alero/screens/alero/call/pipeline_page.dart';
import 'package:alero/screens/alero/prospect/call_bio_data_text_field.dart';
import 'package:alero/utils/constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:alero/style/theme.dart' as Style;
import 'package:intl/intl.dart';

class DealsAdd extends StatefulWidget {
  final String? searchQuery;

  DealsAdd({this.searchQuery});

  @override
  _DealsAddState createState() => _DealsAddState();
}

class _DealsAddState extends State<DealsAdd> {
  String? pipelineId;
  String? prospectName;
  String? prospectType;
  String? customerName;
  String? customerType;
  TransactionType? transactionType;
  late String amount;
  String? currency;
  DateTime startDate = DateTime.now();
  String? expectedDealDate;
  late String tenor;
  late String feesRate;
  late String interestRate;
  String? accountNo;
  ProductDetails? selectedProductType;
  late String netInterestMargin;
  String? transactionComment;
  late String dealProbability;
  double? totalRevenue;
  double? grossRevenue;
  double? feesRevenue;
  double? nrff;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isProspect = false;
  bool visible = false;

  TextEditingController textController = new TextEditingController();

  var apiService = AleroAPIService();
  List prospectOnSearch = [];
  ProspectDetailsResponse? prospects;
  List<SearchUserResponse> search = [];
  var searchResult;

  @override
  void initState() {
    getPipelineCurrency();
    getProductType();
    super.initState();
  }

  TextEditingController _filterController = new TextEditingController();
  Map<String, dynamic>? customerDetails = HashMap();
  TextEditingController myController = new TextEditingController();
  List<TransactionType> transactionType0 = [];

  DateTime dealDate = DateTime.now();
  late DateTime date;

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: dealDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
    );
    if (_datePicker != null && DateFormat('dd/MM/yyyy').format(_datePicker) != expectedDealDate) {
      setState(() {
        expectedDealDate = _datePicker.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Pipeline Deal",
                  style: kDealsBlueHeading,
                ),
                SizedBox(height: 5.0),
                Text(
                  "Enter customer's account number or prospect's name to add new deal",
                  style: kDealsHeading,
                ),
                SizedBox(height: 8.0),
                Text(
                  "Create Pipeline Deal",
                  style: kDealsHeading.copyWith(color: Colors.black54, fontSize: 16.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Customer\'s Account Name or Number",
                        style: kDealsHeading,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                          controller: _filterController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide.none),
                            suffixIcon: IconButton(
                              icon: Icon(EvaIcons.searchOutline),
                              color: Style.Colors.buttonColor,
                              onPressed: () async {
                                customerDetails = await apiService.searchCustomer(_filterController.text);
                                myController.value = TextEditingValue(text: customerDetails!["customerName"]);
                                isProspect = true;
                                setState(() {});
                              },
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                      child: Text(
                        "OR",
                        style: kDealsBlueHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Prospect\'s Name",
                              style: kDealsHeading,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              onTap: () async {
                                var _prospects = await apiService.getProspects();
                                visible = true;
                                setState(() {
                                  prospects = _prospects;
                                  prospectOnSearch = prospects!.result!.userProspects!.toList();
                                });
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintText: prospectName,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide.none),
                                suffixIcon: IconButton(
                                  icon: Icon(EvaIcons.searchOutline),
                                  color: Style.Colors.buttonColor,
                                  onPressed: () {
                                    setState(() {
                                      visible = false;
                                      isProspect = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                // Below gives the list of prospects
                if (visible)
                  Card(
                    elevation: 2,
                    child: Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: prospectOnSearch.length,
                        itemBuilder: (context, index) {
                          var prospect = prospectOnSearch[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: Text(textController.text.isNotEmpty ? prospectOnSearch[index] : prospect.prospectName,
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14.0)),
                                    onTap: () {
                                      setState(() {
                                        prospectName = prospect.prospectName;
                                        myController.value = TextEditingValue(text: prospect.prospectName);
                                        prospectType = prospect.prospectType;
                                      });
                                      visible = false;
                                      isProspect = true;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      padding: EdgeInsets.only(bottom: 5.0),
                    ),
                  ),
                SizedBox(
                  height: 15,
                ),
                if (isProspect == true)
                  Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          clipBehavior: Clip.none,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 7.0),
                                child: Text(
                                  "Customer Found",
                                  style: kDealsBlueHeading,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Customer\'s Name",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      prospectController: myController,
                                      hintText: customerDetails!["customerName"] ?? prospectName,
                                      textInputAction: TextInputAction.next,
                                      readOnly: true,
                                      onChanged: () {},
                                    )
                                  ],
                                ),
                              ),
                              myController.value == null
                                  ? Text("")
                                  : myController == null
                                      ? Text("")
                                      : getProductTypeDropDownComponent(context, productTypes),
                              selectedProductType?.transactionTypes == null
                                  ? getTransactionTypeDropDownComponent(context, transactionType0)
                                  : getTransactionTypeDropDownComponent(context, selectedProductType!.transactionTypes),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Amount",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      validator: (String? value) {
                                        if (value == null) return null;
                                        if (value.isEmpty) {
                                          return 'Pls, enter amount.';
                                        } else if (num.tryParse(value) == null) {
                                          return 'Please enter a valid amount.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        amount = value;
                                      },
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      readOnly: false,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Tenor (In Months)",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      validator: (value) {
                                        if (value == null) return null;
                                        if (value.isEmpty) {
                                          return 'Pls, fill out this field.';
                                        } else if (num.tryParse(value) == null) {
                                          return 'Please enter a valid tenor.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        tenor = value;
                                      },
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      readOnly: false,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Interest Rate (%)",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      validator: (String? value) {
                                        if (value == null) return null;
                                        if (value.isEmpty) {
                                          return 'Pls, fill out this field.';
                                        } else if (num.tryParse(value) == null) {
                                          return 'Please enter a valid tenor.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        interestRate = value;
                                      },
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      readOnly: false,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Expected Deal Date",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      validator: (String? value) {
                                        if (value == null) {
                                          return 'Nothing has been picked yet.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        List<String> dateValues = value.split('/');
                                        date = DateTime(int.parse(dateValues[2]), int.parse(dateValues[1]), int.parse(dateValues[0]));
                                        expectedDealDate = date.toIso8601String();
                                      },
                                      textInputAction: TextInputAction.next,
                                      readOnly: false,
                                      hintText:
                                          expectedDealDate == null ? 'DD/MM/YYY' : DateFormat('dd/MM/yyy').format(DateTime.parse(expectedDealDate!)),
                                      hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.calendar_today),
                                        color: Style.Colors.buttonColor,
                                        onPressed: () {
                                          setState(() {
                                            _selectDate(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Deal Probability (%)",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      validator: (String? value) {
                                        if (value == null) return null;
                                        if (value.isEmpty) {
                                          return 'Pls, fill out this field.';
                                        } else if (num.tryParse(value) == null) {
                                          return 'Please enter a valid tenor.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        dealProbability = value;
                                      },
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      readOnly: false,
                                    ),
                                  ],
                                ),
                              ),
                              prospectType != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Customer Type",
                                            style: kDealsDetailsTextStyle,
                                          ),
                                          CallTextField(
                                            fillColor: Colors.white,
                                            keyboardType: TextInputType.none,
                                            hintText: prospectType,
                                            readOnly: false,
                                            onChanged: () {},
                                          ),
                                        ],
                                      ),
                                    )
                                  : currencyDropDownComponent(context, customerTypes, true),
                              currencies == null ? Text('') : currencyDropDownComponent(context, currencies, false),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Fees Rate (%)",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      onChanged: (value) {
                                        feesRate = value;
                                      },
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      readOnly: false,
                                      validator: (String? value) {
                                        if (value == null) return null;
                                        if (value.isEmpty) {
                                          return 'Pls, fill out this field.';
                                        } else if (num.tryParse(value) == null) {
                                          return 'Please enter a valid tenor.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Net Interest Margin (%)",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      validator: (String? value) {
                                        if (value == null) return null;
                                        if (value.isEmpty) {
                                          return 'Pls, fill out this field.';
                                        } else if (num.tryParse(value) == null) {
                                          return 'Please enter a valid tenor.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        netInterestMargin = value;
                                      },
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      readOnly: false,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        "Transaction Comment",
                                        style: kDealsDetailsTextStyle,
                                      ),
                                    ),
                                    CallTextField(
                                      fillColor: Colors.white,
                                      validator: (String? value) {
                                        if (value == null) return null;
                                        if (value.isEmpty) {
                                          return 'Pls, enter comment.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        transactionComment = value;
                                      },
                                      readOnly: false,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0, bottom: 14.0, top: 10.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      child: const Text(
                                        'Add Pipeline Deal',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await getAllRevenueValues();
                                          var info = addDealDetails();
                                          await apiService.addNewPipelineDeal(info);
                                          showAlertDialog(context);
                                        } else {
                                          print('Unsuccessful.');
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CallBottomNavigationBar(),
    );
  }

  /// Get feesRevenue, grossRevenue, totalRevenue, and nrff.
  ResultRev? revenueValue;
  Future<void> getAllRevenueValues() async {
    var _revenue = await apiService.getRevenueValues(amount, feesRate, interestRate, netInterestMargin);
    setState(() {
      revenueValue = _revenue.result.result;
    });
  }

  addDealDetails() {
    return {
      'customerName': prospectName ?? customerName,
      'customerType': prospectType ?? customerType,
      'transactionType': transactionType!.transaction,
      'amount': double.parse(amount),
      'currency': currency,
      'startDate': startDate.toIso8601String(),
      'expectedDealDate': expectedDealDate,
      'tenor': int.parse(tenor),
      'feesRate': double.parse(feesRate),
      'interestRate': double.parse(interestRate),
      'productType': selectedProductType!.product,
      'netInterestMargin': double.parse(netInterestMargin),
      'transactionComment': transactionComment,
      'dealProbability': double.parse(dealProbability),
      'totalRevenue': revenueValue!.totalRevenue,
      'feesRevenue': revenueValue!.feesRevenue,
      'grossRevenue': revenueValue!.grossRevenue,
      'nrff': revenueValue!.nrff,
    };
  }

  showAlertDialog(BuildContext context) {
    Widget closeButton = TextButton(
        child: Text(
          'Close',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PipelinePage(groupId: ''),
            ),
          );
        });

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 200.0,
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Center(child: Icon(Icons.thumb_up_alt_sharp, size: 35, color: Colors.lightBlueAccent)),
          ),
          SizedBox(height: 20.0),
          Text(
            'You have successfully added a deal.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regular',
            ),
          ),
        ],
      ),
      actions: [closeButton],
    );

    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  AppBar appBar() => AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Style.Colors.blackTextColor,
            size: 20,
          ),
        ),
        backgroundColor: Colors.lightBlue.shade100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
                icon: Icon(Icons.home),
                iconSize: 28.0,
                color: Style.Colors.buttonColor,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/landing', (Route<dynamic> route) => false);
                }),
          ),
        ],
      );

  List<ProductDetails>? productTypes;
  getProductType() async {
    List<ProductDetails>? _productType = await apiService.getPipelineProductType();
    setState(() {
      productTypes = _productType;
    });
  }

  /// Dropdown for productType
  ButtonTheme productTypeAndroidDropDown(List<ProductDetails> dropDownList) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<ProductDetails>(
        value: selectedProductType,
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 37,
        hint: getValue(selectedProductType?.product),
        dropdownColor: Colors.white,
        items: dropDownList.map(buildProductTypeItem).toList(),
        onChanged: (value) {
          setState(() {
            selectedProductType = value;
          });
        },
      ),
    );
  }

  CupertinoPicker productTypeIOSPicker(List<ProductDetails> dropDownList) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children: dropDownList.map(buildProductTypeItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          selectedProductType = productTypes![value];
        });
        final item = productTypes![value];
      },
      magnification: 0.7,
    );
  }

  Widget getProductTypeDropDownComponent(BuildContext context, List<ProductDetails>? dropDownList) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Type',
            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w700, fontSize: 15),
          ),
          SizedBox(height: 5),
          Platform.isIOS ? productTypeIOSPicker(dropDownList!) : productTypeAndroidDropDown(dropDownList!),
        ],
      ),
    );
  }

  DropdownMenuItem<ProductDetails> buildProductTypeItem(ProductDetails item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item.product!,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 5, fontFamily: 'Poppins-Regular', fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }
    if (Platform.isAndroid) {
      return DropdownMenuItem(
        value: item,
        child: Text(
          item.product!,
          style: TextStyle(height: 0.2, fontWeight: FontWeight.w400, fontSize: 20, fontFamily: 'Poppins-Regular', fontStyle: FontStyle.italic),
        ),
      );
    }
    return DropdownMenuItem(
      child: Container(),
    );
  }

  Text getValue(String? value) {
    if (value == null || value.isEmpty) {
      return Text('Select One', style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    } else {
      return Text(value, style: TextStyle(height: 0.4, fontFamily: 'Poppins-Regular'));
    }
  }

  /// Dropdown for transactionType
  ButtonTheme transactionTypeAndroidDropDown(List<TransactionType> dropDownList) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<TransactionType>(
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 37,
        dropdownColor: Colors.white,
        hint: getValue(transactionType?.transaction),
        items: dropDownList.map(buildTransactionTypeItem).toList(),
        onChanged: (value) {
          setState(() {
            transactionType = value;
          });
        },
      ),
    );
  }

  CupertinoPicker transactionTypeIOSPicker(List<TransactionType> dropDownList) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children: dropDownList.map(buildTransactionTypeItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          transactionType = selectedProductType!.transactionTypes![value];
        });
        final item = selectedProductType!.transactionTypes![value];
      },
      magnification: 0.7,
    );
  }

  Widget getTransactionTypeDropDownComponent(BuildContext context, List<TransactionType>? dropDownList) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Type',
            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w700, fontSize: 15),
          ),
          SizedBox(height: 5),
          Platform.isIOS ? transactionTypeIOSPicker(dropDownList!) : transactionTypeAndroidDropDown(dropDownList!),
        ],
      ),
    );
  }

  DropdownMenuItem<TransactionType> buildTransactionTypeItem(TransactionType item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item.transaction!,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 5, fontFamily: 'Poppins-Regular', fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }
    if (Platform.isAndroid) {
      return DropdownMenuItem(
        value: item,
        onTap: () {},
        child: Text(
          item.transaction!,
          style: TextStyle(height: 0.2, fontWeight: FontWeight.w400, fontSize: 20, fontFamily: 'Poppins-Regular', fontStyle: FontStyle.italic),
        ),
      );
    }
    return DropdownMenuItem(
      child: Container(),
    );
  }

  List<String> customerTypes = [
    'INDIVIDUAL',
    'NON-INDIVIDUAL',
  ];

  List<String>? currencies;
  getPipelineCurrency() async {
    List<String>? _currency = await apiService.getPipelineCurrencies();
    setState(() {
      currencies = _currency;
    });
  }

  /// Dropdowns for currency and customerType
  ButtonTheme currencyAndroidDropDown(List<String> dropDownList, bool isCurrency) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        isExpanded: true,
        iconEnabledColor: Colors.lightBlue,
        iconSize: 37,
        dropdownColor: Colors.white,
        hint: getValue(isCurrency ? customerType : currency),
        items: dropDownList.map(buildCurrencyItem).toList(),
        onChanged: (value) {
          setState(() {
            if (isCurrency) {
              customerType = value;
            } else {
              currency = value;
            }
          });
        },
      ),
    );
  }

  CupertinoPicker currencyIOSPicker(List<String> dropDownList, bool isCurrency) {
    return CupertinoPicker(
      looping: true,
      diameterRatio: 10,
      backgroundColor: Colors.black12,
      itemExtent: 50,
      children: dropDownList.map(buildCurrencyItem).toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          if (isCurrency) {
            customerType = customerTypes[value];
          } else {
            currency = currencies![value];
          }
        });
        final item = customerTypes[value];
        print("Selected Item = $item");
      },
      magnification: 0.7,
    );
  }

  Widget currencyDropDownComponent(BuildContext context, List? dropDownList, bool isCurrency) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCurrency ? 'Customer Type' : 'Currency',
            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w700, fontSize: 15),
          ),
          SizedBox(height: 5),
          Platform.isIOS
              ? currencyIOSPicker(dropDownList as List<String>, isCurrency)
              : currencyAndroidDropDown(dropDownList as List<String>, isCurrency),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildCurrencyItem(String item) {
    if (Platform.isIOS) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 5, fontFamily: 'Poppins-Regular', fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }
    if (Platform.isAndroid) {
      return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(height: 0.2, fontWeight: FontWeight.w400, fontSize: 20, fontFamily: 'Poppins-Regular', fontStyle: FontStyle.italic),
        ),
      );
    }
    return DropdownMenuItem(
      child: Container(),
    );
  }
}
