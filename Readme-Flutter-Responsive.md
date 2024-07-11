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
