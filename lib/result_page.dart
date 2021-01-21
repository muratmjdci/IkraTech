import 'dart:convert';

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final result;
  const ResultPage({this.result});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "$result",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}
