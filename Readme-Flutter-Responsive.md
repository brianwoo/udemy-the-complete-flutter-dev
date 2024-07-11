# Flutter Responsive and Adaptive UI

## Lock UI into Portrait Mode
- In main.dart, main()

```dart
void main() {
  // NOTE: Ensure Portrait mode works properly
  WidgetsFlutterBinding.ensureInitialized();

  // Setting orientation. Use then because
  // setPreferredOrientations returns a Future
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (value) {
      // Do the regular runApp...
      runApp(
        MaterialApp()....
      );
    }
  );
}
```

## MediaQuery - Get Device's Width & Height
```dart
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
```

## Understanding Widget Size Constraints (Academind explains)
- All Widgets get sized based on their size preferences and parent widget size constraints
- However, size preferences vary for different Widgets
- E.g. Scaffold's Constraints:
  - Height: Max device height
  - Width: Max device width
- E.g. Column's Preferences:
  - Height: As much as possible (INFINITY)
  - Width: As much as needed by children
- E.g. Row's Preferences:
  - Height: As much as needed by children
  - Width: As much as possible (INFINITY)

Hence with Scaffold's constraints, Column and Row display fine


