import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetHandler;

  Result(this.totalScore, this.resetHandler);

  String get resultPhrase {
    //a getter function used to return a single value
    if (totalScore <= 10)
      return "positive";
    else
      return "negative";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text(
            'Restart',
            style: TextStyle(fontSize: 30),
          ),
          textColor: Colors.blue,
          onPressed: resetHandler,
        )
      ],
    ));
  }
}
