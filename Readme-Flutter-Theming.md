# Material Theming

## Basics
- Setup a Base Color Scheme - use ColorScheme.fromSeed()
- From MaterialApp, setup ThemeData, use copyWith()
- Override specific widget color as desired
- onPrimaryContainer means foreground color, also the same for SecondaryContainer
- primaryContainer means background color, same for onSecondaryContainer

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
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
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

## A Simpler Example (Setup basic color theme and font)
```dart
final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  surface: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: theme,
      home: const PlacesScreen(),
    );
  }
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

## Light / Dark Modes
- Toggle Dark/Light Theme from System Settings
  
```dart

// Define a dark ColorScheme, NOTE: make sure brightness is set to dark
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 37, 6, 17),
);

void main() {
  runApp(
    MaterialApp(
      home: MaterialApp(

        // ThemeMode here set to follow system, can also default to light or dark
        themeMode: ThemeMode.system,

        // Add Dark mode theme
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),

        // The Light mode theme from previous section
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            ...
            ...
          ),
        ),
     );
}
```

## Determine if System Is Running in Dark Mode
```dart
final isDarkMode =
    MediaQuery.of(context).platformBrightness == Brightness.dark;
```

