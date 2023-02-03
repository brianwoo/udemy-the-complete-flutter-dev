import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/pages/bmi_page.dart';

void main() {
  testWidgets(
    'Given user on BMIPage when user clicks + button then weight increment by 1',
    (tester) async {
      // Arrange
      await tester.pumpWidget(CupertinoApp(home: BMIPage()));
      var weightIncrementBtn = find.byKey(Key("weight_plus"));
      // Act
      await tester.tap(weightIncrementBtn);
      await tester.pump();
      // Assert
      var text = find.text('161');
      expect(text, findsOneWidget);
    },
  );
}
