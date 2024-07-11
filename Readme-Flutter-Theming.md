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
                  fontWeight: FontWeight.bold,
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

## To Use / Override Theme Settings
- Use Theme.of(context).xxxx
  
```dart
// Copy from textTheme titleLarge, but only override to Italic
Text(
  expense.title,
  style: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontStyle: FontStyle.italic,
      ),
),

// Use the base colorScheme and cardTheme.margin.horizontal
Container(
  color: Theme.of(context).colorScheme.error.withOpacity(0.75),
  margin: EdgeInsets.symmetric(
    horizontal: Theme.of(context).cardTheme.margin!.horizontal,
  ),
),
```


