

import 'dart:async';
import 'package:alero/dummy/generated_quotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class LoadingQuotes extends StatefulWidget {
  final String title;

  const LoadingQuotes({required this.title});

  @override
  State<LoadingQuotes> createState() => _LoadingQuotesState();
}

class _LoadingQuotesState extends State<LoadingQuotes> {
  late int _currentIndex;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = _generateRandomIndex();
    _startTimer();
  }

  int _generateRandomIndex() {
    return DateTime.now().millisecondsSinceEpoch % 20;
  }

  void _changeIndex() {
    setState(() {
      _currentIndex = _generateRandomIndex();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      _changeIndex();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quote = Quotes.data[_currentIndex];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 15, width: 15,child: CircularProgressIndicator(color: Colors.black38, strokeWidth: 2)),
                  SizedBox(width: 6.0),
                  Text('Fetching ${ widget.title } data', style: TextStyle(letterSpacing: 1, fontFamily: "Poppins-Regular", fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(height: 15),
              SvgPicture.asset('assets/icons/light_bulb.svg',
                width: 60,
                height: 40,
              ),
              SizedBox(height: 12),
              Text(
                quote.title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Poppins-Regular', color: Colors.black54),
              ),
              SizedBox(height: 6),
              Text(quote.description,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: 'Poppins-Regular'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
