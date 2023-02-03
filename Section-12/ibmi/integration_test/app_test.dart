import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("end-to-end app test", () {
    // Arrange
    var weightIncrementButton = find.byKey(Key('weight_plus'));
    var ageIncrementButton = find.byKey(Key('age_plus'));
    var calculationBMIButton = find.byType(CupertinoButton);

    testWidgets(
      "Given app is ran when height, age input, calculateBMI button pressed, then correct BMI return",
      (widgetTester) async {
        // Arrage
        main();

        // Act
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(weightIncrementButton);
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(ageIncrementButton);
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(calculationBMIButton);
        await widgetTester.pumpAndSettle();
        final resultTest = find.text('Normal');

        // Assert
        expect(resultTest, findsOneWidget);
      },
    );
  });
}
