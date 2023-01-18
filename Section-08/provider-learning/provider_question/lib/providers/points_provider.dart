import 'package:flutter/material.dart';

class PointsProvider extends ChangeNotifier {
  double _points = 0.0;

  PointsProvider();

  double getPoints() {
    return _points;
  }

  void setPoints(double difficulty) {
    _points = difficulty;
    notifyListeners();
  }

  String getResult() {
    if (_points == 0.0) {
      return "Low";
    } else if (_points == 1.0) {
      return "Medium";
    } else {
      return "High";
    }
  }
}
