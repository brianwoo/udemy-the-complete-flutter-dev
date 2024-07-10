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
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 15,
                ),
              ),
        ),
        home: const Expenses(),
      ),
    ),
  );
}

```


