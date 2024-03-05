import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ConcessionStatus extends StatefulWidget {

  @override
  State<ConcessionStatus> createState() => _ConcessionStatusState();
}

class _ConcessionStatusState extends State<ConcessionStatus> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      elevation: 5,
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 15.0,
            dataRowHeight: 36,
            headingRowHeight: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
            columns: [
              DataColumn(label: Text('\nStatus', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Customer\nAccount', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('\nName', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Product\nType', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('Concession\nType', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
              DataColumn(label: Text('\nAction', style: kCprHeadingText.copyWith(color: Colors.lightBlue.shade600))),
            ],
            rows: List.generate(10, (index) {
              return DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                      }
                      if (index.isOdd) {
                        return Colors.grey.withOpacity(0.15);
                      }
                      return null;
                    }),
                  cells: [
                    DataCell(Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: SizedBox(width: 70, child: Text('Approved', style: kDealsHeaderStyle)),
                    )),
                    DataCell(Text('8160232043', style: kDealsHeaderStyle)),
                    DataCell(Text('Chidiebere Nwachukwu Designs', style: kDealsHeaderStyle)),
                    DataCell(Text('Overdraft', style: kDealsHeaderStyle)),
                    DataCell(Text('CA_0023', style: kDealsHeaderStyle)),
                    DataCell(
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Container(
                              height: 30,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.view_compact_outlined, color: Colors.white70
                                      ),
                                      Text("View",
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.white70,
                                              fontFamily: 'Poppins-Regular',
                                              fontWeight: FontWeight.w700)),
                                    ]
                                ),
                              ),
                            ),
                          ),
                        )),
                  ]);
            }),
          ),
        ),
      ),
    );
  }
}
