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
- E.g. Scaffold's (Parent) Constraints:
  - Height: Max device height
  - Width: Max device width
- E.g. Column's (Child) Preferences:
  - Height: As much as possible (INFINITY)
  - Width: As much as needed by children
- E.g. Row's (Child) Preferences:
  - Height: As much as needed by children
  - Width: As much as possible (INFINITY)

Hence with Scaffold's constraints, Column and Row display fine, even Column wants height to be INFINITE and Row wants width to be INFINITE.

### Problem: When Parent has no constraint and Child wants INFINITE width or height
- E.g. Column's (Parent) Constraints:
  - Height: No Constraint
  - Width: Available width from screen / remaining width from parent
- E.g. ListView's (Child) Preferences:
  - Height: As much as possible (INFINITY)
  - Width: As much as needed by children

With no constraint on height and child wants INFINITE height, Flutter throws an Exception or out of the boundary of the screen.

### To Fix: Add Expanded to set constraints of the Child
- E.g. Expanded's (Parent) Constraints:
  - Height: Actual height of the Child
  - Width: Available width from screen / remaining width from parent
- E.g. ListView's (Child) Preferences:
  - Height: As much as possible (INFINITY)
  - Width: As much as needed by children

