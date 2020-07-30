import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(); // _ turns the public class to private
  }
}

class _MyAppState extends State<MyApp> {
  var _questionNumber = 0;
  var _totalScore = 0;
  void _answerQ(int score) {
    setState(() {
      //function tells flutter that the state is changed and it has to rerender
      _questionNumber++;
      _totalScore += score;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionNumber = 0;
      _totalScore = 0;
    });
  }

//final is runtime constant while const is compile time constant

  //creating map instead of class
  final _questions = [
    {
      'questionText': 'What\'s your fav color',
      'answers': [
        {'text': 'red', 'score': 4},
        {'text': 'blue', 'score': 5},
        {'text': 'green', 'score': 5},
        {'text': 'black', 'score': 5}
      ]
    },
    {
      'questionText': 'What\'s your fav animal',
      'answers': [
        {'text': 'hippo', 'score': 4},
        {'text': 'rabbit', 'score': 4},
        {'text': 'monkey', 'score': 4},
        {'text': 'tigers', 'score': 4}
      ]
    },
    {
      'questionText': 'What\'s your fav subject',
      'answers': [
        {'text': 'maths', 'score': 4},
        {'text': 'science', 'score': 4},
        {'text': 'arts', 'score': 4},
        {'text': 'commerce', 'score': 4}
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: _questionNumber < _questions.length
            ? Quiz(
                answerQ: _answerQ,
                questions: _questions,
                questionNumber: _questionNumber)
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
