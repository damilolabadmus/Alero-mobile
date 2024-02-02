

import 'package:alero/screens/alero/components/transaction_inflow_card.dart';
import 'package:alero/screens/alero/components/transaction_outflow_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerTrendsGraphs extends StatefulWidget {
  final String? customerId, groupId, customerAccountNo;

  const CustomerTrendsGraphs(
      {Key? key, required this.customerId, required this.groupId, this.customerAccountNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerTrendsGraphsState();
  }
}

class _CustomerTrendsGraphsState extends State<CustomerTrendsGraphs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 222,
          margin: EdgeInsets.only(right: 10, left: 10),
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
          child: TransactionInflowCard(
              customerId: widget.customerId,
              groupId: widget.groupId,
              customerAccountNo: widget.customerAccountNo
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
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
          child: TransactionOutflowCard(
              customerId: widget.customerId,
              groupId: widget.groupId,
              customerAccountNo: widget.customerAccountNo
          ),
        ),
      ],
    );
  }
}
