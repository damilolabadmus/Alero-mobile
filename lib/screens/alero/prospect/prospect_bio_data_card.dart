import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../style/theme.dart' as Style;

class ProspectBioDataCard extends StatelessWidget {
  const ProspectBioDataCard({Key key,

    this.productOfferedValue,
    this.customerWalletSizeValue,
    this.businessSegmentValue,
    this.contactPersonNameValue,
    this.contactPersonEmailValue,
    this.keyPromoterNameValue,
    this.prospectAddressValue,
    this.prospectTypeValue,
    this.contactPersonPhoneNoValue,
    this.prospectConverted,
    this.accountNo,
  }) : super(key: key);

  final String productOfferedValue;
  final String customerWalletSizeValue;
  final String businessSegmentValue;
  final String contactPersonNameValue;
  final String contactPersonEmailValue;
  final String keyPromoterNameValue;
  final String prospectAddressValue;
  final String prospectTypeValue;
  final String contactPersonPhoneNoValue;
  final bool prospectConverted;
  final String accountNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 900,
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
              child: Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Style.Colors.searchActiveBg,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color:
                                          Style.Colors.searchActiveBg)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    child: Text(
                                      productOfferedValue,
                                      style: TextStyle(
                                        color:
                                        Style.Colors.searchActiveBgText,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                              color: Style.Colors.biodataBlue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(right: 10),
                                                  child: Icon(Icons.attach_money, size: 15, color: Colors.blueGrey.shade400),
                                                ),
                                                Text(businessSegmentValue,
                                                    style: TextStyle(
                                                      color: Style
                                                          .Colors.blackTextColor,
                                                      fontSize: 13.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'Poppins-Regular',
                                                    )),
                                              ],
                                            )),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 8.0),
                                                  child: Icon(Icons.ad_units_outlined, size: 15, color: Colors.blueGrey.shade400)
                                              ),
                                              Text('Wallet Size',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .lightBlue,
                                                    fontSize: 10.0,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontFamily:
                                                    'Poppins-Regular',
                                                  )),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 25.0),
                                                child: Text(customerWalletSizeValue,
                                                    style: TextStyle(
                                                      color: Style.Colors
                                                          .blackTextColor,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: SvgPicture.asset(
                                            'assets/customer/biodata/biodata_call.svg',
                                          ),
                                        ),
                                        Text(contactPersonPhoneNoValue,
                                            style: TextStyle(
                                              color:
                                              Style.Colors.blackTextColor,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins-Regular',
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                              color: Style.Colors.biodataRed,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(Icons.person, size: 15, color: Colors.blueGrey.shade400)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: Text('Contact Name',
                                              style: TextStyle(
                                                color:
                                                Colors.lightBlue,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins-Regular',
                                              )),
                                        ),
                                        Text(contactPersonNameValue,
                                            style: TextStyle(
                                              color:
                                              Style.Colors.blackTextColor,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins-Regular',
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(Icons.amp_stories_sharp, size: 15, color: Colors.blueGrey.shade400)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right:20.0),
                                          child: Text('Introducer\s Name',
                                              style: TextStyle(
                                                color: Colors.lightBlue,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins-Regular',
                                              )),
                                        ),
                                        Text(keyPromoterNameValue,
                                            style: TextStyle(
                                              color:
                                              Style.Colors.blackTextColor,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins-Regular',
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: SvgPicture.asset(
                                            'assets/customer/biodata/biodata_mail.svg',
                                          ),
                                        ),
                                        Text(contactPersonEmailValue,
                                            style: TextStyle(
                                              color:
                                              Style.Colors.blackTextColor,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins-Regular',
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                              color: Style.Colors.biodataGreen,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                    EdgeInsets.only(right: 10),
                                                    child: Icon(Icons.add_location, size: 15, color: Colors.blueGrey.shade400)
                                                ),
                                                Text(prospectAddressValue,
                                                    style: TextStyle(
                                                      color: Style
                                                          .Colors.blackTextColor,
                                                      fontSize: 13.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    )),
                                              ],
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10),
                                                child: SvgPicture.asset(
                                                  'assets/customer/biodata/biodata_profession.svg',
                                                ),
                                              ),
                                              Text(prospectTypeValue,
                                                  style: TextStyle(
                                                    color: Style.Colors
                                                        .blackTextColor,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontFamily:
                                                    'Poppins-Regular',
                                                  )),
                                            ],
                                          ),
                                        ),
                                        accountNo == null ? Text('') : accountNo.isEmpty ? Text('') :
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 2.0),
                                                  child: Icon(Icons.ad_units_outlined, size: 15, color: Colors.blueGrey.shade400)
                                              ),
                                              Text('Account Number',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .lightBlue,
                                                    fontSize: 10.0,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontFamily:
                                                    'Poppins-Regular',
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Text(accountNo,
                                                    style: TextStyle(
                                                      color: Style.Colors
                                                          .blackTextColor,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
