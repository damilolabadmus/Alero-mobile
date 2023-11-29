import 'package:alero/network/AleroAPIService.dart';
import 'package:alero/screens/alero/prospect/prospect_bio_data.dart';
import 'package:alero/screens/alero/prospect/prospect_icon_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'delete_prospect_confirmed.dart';

class ViewProspectButton extends StatefulWidget {
  String prospectId;
  String keyPromoterName;
  String prospectName;
  String prospectAddress;
  String prospectType;
  String businessSegment;
  String productOffered;
  double customerWalletSize;
  String contactPersonName;
  String contactPersonEmail;
  String contactPersonPhoneNo;
  String contactPersonAddress;
  bool prospectConverted;
  String accountNo;
  String introducerStaffCode;

  ViewProspectButton(
      this.prospectId,
      this.keyPromoterName,
      this.prospectName,
      this.prospectAddress,
      this.prospectType,
      this.businessSegment,
      this.productOffered,
      this.customerWalletSize,
      this.contactPersonName,
      this.contactPersonEmail,
      this.contactPersonPhoneNo,
      this.contactPersonAddress,
      this.prospectConverted,
      this.accountNo,
      this.introducerStaffCode,
      );

  @override
  _ViewProspectButtonState createState() => _ViewProspectButtonState(prospectId,keyPromoterName, prospectName, prospectAddress, prospectType, businessSegment, productOffered,
      customerWalletSize, contactPersonName, contactPersonEmail, contactPersonPhoneNo, contactPersonAddress, prospectConverted, accountNo, introducerStaffCode);
}

class _ViewProspectButtonState extends State<ViewProspectButton> {
  String prospectId;
  String keyPromoterName;
  String prospectName;
  String prospectAddress;
  String prospectType;
  String businessSegment;
  String productOffered;
  double customerWalletSize;
  String contactPersonName;
  String contactPersonEmail;
  String contactPersonPhoneNo;
  String contactPersonAddress = "";
  bool prospectConverted;
  String accountNo;
  String introducerStaffCode = "";


  _ViewProspectButtonState(
      this.prospectId,
      this.keyPromoterName,
      this.prospectName,
      this.prospectAddress,
      this.prospectType,
      this.businessSegment,
      this.productOffered,
      this.customerWalletSize,
      this.contactPersonName,
      this.contactPersonEmail,
      this.contactPersonPhoneNo,
      this.contactPersonAddress,
      this.prospectConverted,
      this.accountNo,
      this.introducerStaffCode,
      );

  var apiService = AleroAPIService();

  @override
  Widget build(BuildContext context) {
    return accountNo.isEmpty ?
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: PopupMenuButton<IconMenu>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onSelected: (value) {
          switch (value) {
            case IconsMenu.view:
              returnProspectBioData(context);
              break;
            case (IconsMenu.delete) :
              showAlert(context);
              break;
          }
        },
        itemBuilder: (context) => IconsMenu.items
            .map((item) => PopupMenuItem<IconMenu>(
          value: item,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(item.icon, color: item.iconColor),
            title: Text(item.text),
          ),
        )).toList(),
      ),
    ) :
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: PopupMenuButton<ConvertedIconMenu>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onSelected: (value) {
          switch (value) {
            case ConvertedIconsMenu.view:
              returnProspectBioData(context);
              break;
            case ConvertedIconsMenu.convert:
              break;
          }
        },
        itemBuilder: (context) => ConvertedIconsMenu.items
            .map((item) => PopupMenuItem<ConvertedIconMenu>(
          value: item,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(item.icon, color: item.iconColor),
            title: Text(item.text),
          ),
        )).toList(),
      ),
    );
  }

  void returnProspectBioData(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProspectBioData(prospectId, keyPromoterName, prospectName, prospectAddress, prospectType,
        businessSegment, productOffered, customerWalletSize, contactPersonName, contactPersonEmail, contactPersonPhoneNo, contactPersonAddress,
        prospectConverted, accountNo, introducerStaffCode),),
    );
  }

  showAlert(BuildContext context) {
    Widget cancelButton = TextButton(
        child: Text(
          'Cancel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        }
    );

    getNewProspectDetails() {
      return{
        'prospectId': prospectId ,
        'keyPromoterName': keyPromoterName,
        'prospectName': prospectName,
        'prospectAddress': prospectAddress,
        'prospectType':prospectType,
        'businessSegment': businessSegment,
        'productOffered': productOffered,
        'walletSize': customerWalletSize,
        'contactPersonName': contactPersonName,
        'contactPersonEmail': contactPersonEmail,
        'contactPersonPhoneNo': contactPersonPhoneNo,
        'contactPersonAddress': contactPersonAddress,
        'prospectConverted': accountNo.isEmpty ? false : accountNo == null ? false : true,
        'accountNo': accountNo ,
        'edit': false,
      };
    }

    confirmDeleteDialog(BuildContext context) {
      showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return DeleteProspectConfirmed();
        },);
    }

    Widget deleteButton = TextButton(
      child: Text(
        'Delete',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins-Regular',
        ),
      ),
      onPressed: () async {
        try{
          var info =  getNewProspectDetails();
          await apiService.deleteProspect(info);
        } catch (e){}
        confirmDeleteDialog(context);
      },
    );

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 220.0,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 5.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(child: Icon(Icons.warning_rounded, size: 30, color: Colors.yellow.shade300)),
          ),
          Text(
            'Are You Sure You Want To Delete This Prospect?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black45,
              fontFamily: 'Poppins-Regular',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    showDialog(
      useRootNavigator:false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}



