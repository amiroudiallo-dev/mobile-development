import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frivia/pages/HomePage.dart';

class HomePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int _maxQuestion = 10;
  List? questions;
  int currentQuestionCount = 0, _correctAnswer = 0, _hightScore = 0;
  final String difficultyLevel;

  BuildContext context;
  HomePageProvider({required this.context, required this.difficultyLevel}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    getQuestionFromApi();
  }

  Future<void> getQuestionFromApi() async {
    print(difficultyLevel);

    var response;
    if (difficultyLevel == 'easy') {
      response = await dio.get('', queryParameters: {
        'amount': 10,
        'category': 18,
        'type': 'boolean',
        'difficulty': 'easy'
      });
    } else if (difficultyLevel == 'meduim') {
      response = await dio.get('', queryParameters: {
        'amount': 10,
        'category': 18,
        'type': 'boolean',
        'difficulty': 'meduim'
      });
    } else {
      response = await dio.get('', queryParameters: {
        'amount': 10,
        'category': 18,
        'type': 'boolean',
        'difficulty': 'hard'
      });
    }

    var data = jsonDecode(response.toString());
    questions = data['results'];
    print(questions);
    notifyListeners();
  }

  String getCurrentQuestion() {
    return questions![currentQuestionCount]['question'];
  }

  void answerQuestion(String _answer) async {
    if (questions != null && currentQuestionCount < questions!.length) {
      bool isCorrect =
          questions![currentQuestionCount]['correct_answer'] == _answer;
      _correctAnswer += isCorrect ? 1 : 0;
      currentQuestionCount++;
      showDialog(
        context: context,
        builder: (BuildContext _buildContext) {
          return Center(
            child: AlertDialog(
              backgroundColor: isCorrect ? Colors.green : Colors.red,
              title: Icon(
                isCorrect ? Icons.check_circle : Icons.cancel_sharp,
                color: Colors.white,
              ),
            ),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context);
      if (currentQuestionCount == _maxQuestion) {
        endGame();
      } else {
        notifyListeners();
      }
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _buildContext) {
          return AlertDialog(
            backgroundColor: Colors.amberAccent,
            title: const Text(
              'End Game!',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            content: Text(
              "Score: $_correctAnswer/$_maxQuestion",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Colors.black),
            ),
          );
        });

    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<void> _invalidDifficultChoice() async {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return const AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: Text(
            'No question available',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
