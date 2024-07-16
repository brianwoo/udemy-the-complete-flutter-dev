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

## Create a Provider (Provider is for STATIC data)
- Add Flutter Riverpod Snippet Extension from Robert Brunhage
```
// Use snippet - type: provider
final mealsProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});
```

## Create a StateNotifierProvider (StateNotifierProvider is for CHANGABLE data)
- Add the StateNotifierProvider & StateNotifier boilerplate code
```
// Use snippet - type: stateNotifier
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {

  // Initial state stored through super constructor
  FavoriteMealsNotifier() : super([]);

  // Method to change state
  // NOTE: always create a new object (list in this case)
  void toggleMealFavoriteStatus(Meal meal) {
    final isMealFavorite = state.contains(meal);

    if (isMealFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

// Use snippet - type: stateNotifierProvider
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
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

  

