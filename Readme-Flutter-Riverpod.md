# Riverpod - App-wide State Management

## Setup

### Installation:
```bash
flutter pub add flutter_riverpod
```

### Wrap App() in ProviderScope()
```dart
// main.dart
void main() {
  runApp(const ProviderScope(child: App()));
}
```

## Create a Provider 
- Add Flutter Riverpod Snippet Extension from Robert Brunhage
```
// Use snippet - type: provider
final mealsProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});
```

## Create Access to Provider
- Access Provider by ref
```dart
@override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((m) {
      return m.isGlutenFree == _selectedFilters[Filter.glutenFree] &&
          m.isLactoseFree == _selectedFilters[Filter.lactoseFree] &&
          m.isVegetarian == _selectedFilters[Filter.vegetarian] &&
          m.isVegan == _selectedFilters[Filter.vegan];
    }).toList();
}
```

## Create a Consumer - Stateful Widget
- Use snippet: stfulConsumer
- Change from StatefulWidget
  - StatefulWidget -> ConsumerStatefulWidget
  - State -> ConsumerState

  

