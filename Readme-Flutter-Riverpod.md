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
## Providers

### Create a Provider (Provider is for STATIC data)
- Add Flutter Riverpod Snippet Extension from Robert Brunhage
```dart
// Use snippet - type: provider
final mealsProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});
```

### Create a StateNotifierProvider (StateNotifierProvider is for CHANGABLE data)
- Add the StateNotifierProvider & StateNotifier boilerplate code
```dart
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

<hr>
<br>

## Consumers

### Create a ConsumerStatefulWidget
- Use snippet: stfulConsumer
- If change from StatefulWidget
  - StatefulWidget -> ConsumerStatefulWidget
  - State -> ConsumerState

### Create a ConsumerWidget
- Use snippet: stlessConsumer
- If change from StatelessWidget
  - StatelessWidget -> ConsumerWidget
 
<hr>
<br>

## Access to Provider
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

## Access to Notifier
- Access Notifier by ref.read(provider.notifier)
```dart
Widget build(BuildContext context, WidgetRef ref) {
  return IconButton(
            onPressed: () => ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealFavoriteStatus(meal),
            icon: const Icon(Icons.star),
          );
}
```



