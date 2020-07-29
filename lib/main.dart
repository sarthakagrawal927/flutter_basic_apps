import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(); // _ turns the public class to private
  }
}

class _MyAppState extends State<MyApp> {
  void answerQ() {
    print("answered");
    setState(() {
      //function tells flutter that the state is changed and it has to rerender
      questionNumber++;
    });
  }

  var questions = ['What\'s your fav color', 'What\'s your fav animal '];
  var questionNumber = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Column(
          children: [
            Text(questions[questionNumber]),
            RaisedButton(
              child: Text('Answer1'),
              onPressed: answerQ,
            ),
            RaisedButton(
              child: Text('Answer2'),
              onPressed:
                  answerQ, //should point to the function instead of executing it
            )
          ],
        ),
      ),
    );
  }
}
