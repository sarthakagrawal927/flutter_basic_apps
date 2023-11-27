import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final Function answerQ;
  final List<Map<String, Object>> questions;
  final int questionNumber;
  Quiz(
      {@required this.answerQ,
      @required this.questions,
      @required this.questionNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionNumber]['questionText']),
        ...(questions[questionNumber]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQ(answer['score']),
              answer['text']); //sending address of function instead
        }).toList()
      ], // ... is spread which takes values of the list and makes them to seperate values which in turn are added to the list above
    );
  }
}
