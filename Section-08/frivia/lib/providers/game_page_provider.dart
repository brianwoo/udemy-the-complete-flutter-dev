import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  static const int _maxQuestions = 10;
  double _difficulty = 0;

  List? questions;
  int _currentQuestionCount = 0;

  // BuildContext context;
  GamePageProvider() {
    // GamePageProvider({required this.context}) {
    print("--- CREATING GamePageProvider ---");
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    // _getQuestionsFromAPI();
  }

  Future<List<dynamic>?> getQuestionsFromAPI() async {
    var _response = await _dio.get(
      "",
      queryParameters: {
        "amount": _maxQuestions,
        "type": 'boolean',
        "difficulty": getDifficultyString().toLowerCase(),
      },
    );
    print(_difficulty.toString() +
        " ===== " +
        getDifficultyString().toLowerCase() +
        " ====== " +
        _response.toString());
    var data = jsonDecode(_response.toString());
    questions = data['results'];
    // notifyListeners();
    return questions;
  }

  String getCurrentQuestionText() {
    return questions != null
        ? questions![_currentQuestionCount]['question']
        : "";
  }

  Future<void> answerQuestion(String answer) async {
    bool isCorrect = questions != null
        ? questions![_currentQuestionCount]['correct_answer'] == answer
        : false;
    _currentQuestionCount++;
    print("isCorrect: $isCorrect");
    // showDialog(
    //     context: context,
    //     builder: (BuildContext ctx) {
    //       return AlertDialog(
    //         backgroundColor: isCorrect ? Colors.green : Colors.red,
    //         title: Icon(
    //           isCorrect ? Icons.check_circle : Icons.cancel_sharp,
    //           color: Colors.white,
    //         ),
    //       );
    //     });
    // await Future.delayed(Duration(seconds: 1));
    // Navigator.pop(context);
    // if (_currentQuestionCount == _maxQuestions) {
    //   endGame();
    // } else {
    //   notifyListeners();
    // }
    notifyListeners();
  }

  Future<void> endGame() async {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext ctx) {
    //     return AlertDialog(
    //       backgroundColor: Colors.blue,
    //       title: Text("End Game!",
    //           style: TextStyle(fontSize: 25, color: Colors.white)),
    //       content: Text("Score: 0/0"),
    //     );
    //   },
    // );
    // await Future.delayed(Duration(seconds: 3));
    // Navigator.pop(context);
    // Navigator.pop(context);
    _currentQuestionCount = 0;
  }

  void setDifficulty(double difficulty) {
    print("setDifficulty " + difficulty.toString());
    _difficulty = difficulty;
    notifyListeners();
  }

  double getDifficulty() {
    return _difficulty;
  }

  String getDifficultyString() {
    if (_difficulty == 0.0) {
      return "Easy";
    } else if (_difficulty == 1.0) {
      return "Medium";
    } else {
      return "Hard";
    }
  }
}
