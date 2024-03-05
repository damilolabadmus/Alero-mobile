import 'package:flutter/material.dart';
import 'concession_status.dart';

class ConcessionReview extends StatefulWidget {

  @override
  State<ConcessionReview> createState() => _ConcessionReviewState();
}

class _ConcessionReviewState extends State<ConcessionReview> {
  @override
  Widget build(BuildContext context) {
    return ConcessionStatus();
  }
}
