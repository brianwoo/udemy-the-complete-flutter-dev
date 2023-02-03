import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/utils/calculator.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  test(
    'Give height and weight when calculateBMI function invoked then correct BMI returned',
    () {
      // Arrange
      const int height = 70, weight = 160;
      // Act
      double bmi = calculateBMI(height, weight);
      // Assert
      expect(bmi, 22.955102040816328);
    },
  );

  test(
    'Give URL when calculateBMIAsync invoked then correct BMI returned',
    () async {
      // Arrange
      final dioMock = DioMock();
      when(() => dioMock.get('https://www.jsonkeeper.com/b/4SNW')).thenAnswer(
        (invocation) => Future.value(
          Response(
            requestOptions:
                RequestOptions(path: 'https://www.jsonkeeper.com/b/4SNW'),
            data: {
              "clark kent": [72, 55]
            },
          ),
        ),
      );
      // Act
      var bmi = await calculateBMIAsync(dioMock);

      // Assert
      expect(bmi, 7.458526234567901);
    },
  );
}
