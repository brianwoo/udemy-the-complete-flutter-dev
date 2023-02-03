import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

double calculateBMI(int height, int weight) {
  return (weight / pow(height, 2)) * 703;
}

Future<double> calculateBMIAsync(Dio dio) async {
  var result = await dio.get('https://www.jsonkeeper.com/b/4SNW');
  var data = result.data;
  var bmi = calculateBMI(data['clark kent'][0], data['clark kent'][1]);
  return bmi;
}
