# Material Theming

## Basics
- Setup a Base Color Scheme - use ColorScheme.fromSeed()
- From MaterialApp, setup ThemeData, use copyWith()
- Override specific widget color as desired

```dart
// Base ColorScheme
var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 196, 34, 88),
);

void main() {
  runApp(
    MaterialApp(
      home: MaterialApp(
        theme: ThemeData().copyWith(   // Copying from Base ColorTheme
            colorScheme: kColorScheme,
             // Overwriting appBarTheme
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
            )),
        home: const Expenses(),
      ),
    ),
  );
}

```


