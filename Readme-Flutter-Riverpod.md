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

- Next:
  - add a Provider / Notifier to provide data & functions
  - add a Consumer to access data & functions
  
<br>

## Providers

### Create a Provider (Provider is for STATIC data)
- Add Flutter Riverpod Snippet Extension from Robert Brunhage
```dart
// Use snippet - type: provider
final mealsProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});
```

## SYNCHRONOUS Provider and Notifier

### Create a NotifierProvider & Notifier (notifier is for CHANGABLE data)
- Add the NotifierProvider & Notifier boilerplate code
```dart
// Use snippet - type: stateNotifier
class FavoriteMealsNotifier extends Notifier<List<Meal>> {

  // NOTE: always create a new object (list in this case)
  bool toggleMealFavoriteStatus(Meal meal) {
    final isMealFavorite = state.contains(meal);

    if (isMealFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  @override
  List<Meal> build() {
    // initial value
    return [];
  }
}

// Use snippet - type: stateNotifierProvider
final favoriteMealsProvider =
    NotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        () => FavoriteMealsNotifier());
```

## ASYNCHRONOUS Provider and Notifier

### Create a AsyncNotifierProvider & AsyncNotifier (notifier is for CHANGABLE data)
- boilerplate code:
```dart
// Use snippet - type: asyncNotifier
class PlacesNotifier extends AsyncNotifier<List<Place>> {
  ///
  /// 2 Options to update the state and trigger a automatic reload in the UI:
  ///

  ///
  /// Option 1: Update local state manually
  /// This method will NOT trigger the notifier.build() again
  ///
  /// Use case: the remote API (DB or REST API) returns a newly inserted obj.
  ///
  void addPlaceAndUpdateLocalState(Place newPlace) async {
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
    });

    // We can then manually update the local cache. For this, we'll need to
    // obtain the previous state.
    // Caution: The previous state may still be loading or in error state.
    // A graceful way of handling this would be to read `this.future` instead
    // of `this.state`, which would enable awaiting the loading state, and
    // throw an error if the state is in error state.
    final previousState = await future;
    state = AsyncData([...previousState, newPlace]);
  }

  ///
  /// Option 2: Use ref.invalidateSelf()
  /// This method WILL trigger the notifier.build() again
  ///
  /// Use case: the remote API (DB or REST API) DOES NOT return a newly
  /// inserted obj. Notifier.build() will be called to pull data.
  ///
  void addPlaceAndInvalidate(Place newPlace) async {
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
    });

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();
  }

  ///
  /// build() - this is called when:
  /// 1. Initially to provide a initial value
  /// 2. After ref.invalidateSelf() is called
  @override
  Future<List<Place>> build() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');

    final places = data
        .map(
          (row) => Place(
            id: row['id'].toString(),
            title: row['title'].toString(),
          ),
        )
        .toList();
    return places;
  }
}

final placesProvider = AsyncNotifierProvider<PlacesNotifier, List<Place>>(() {
  return PlacesNotifier();
});
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
  - build(BuildContext ctx) -> build(BuildContext ctx, WidgetRef ref)
 
<hr>
<br>

## Access to NotifierProvider / Provider
- Access NotifierProvider by ref
  - ref.read(): will only read the value ONCE
  - ref.watch(): will monitor and read the value when changed. When a value has been changed, the build() method will get triggered to rebuild the widget tree. This can help eliminating the need for ConsumerStatefulWidget.
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

## Access to AsyncNotifierProvider
- AsyncNotifierProvider returns an AsyncValue object
- AsyncValue is NOT compatible with FutureBuilder, use:
  - AsyncValue.data, AsyncValue.error, AsyncValue.loading instead
```dart
@override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return places.when(
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            title: Text(
              data[index].title,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
      error: (e, st) => Center(child: Text(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
```

## Access to Notifier (To update a value)
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





## Provider depends on another Provider
- it's possible to do it like React Hook where a Hook depends on a value change
```dart
final filteredMealProvider = Provider<List<Meal>>((ref) {
  // depending on filtersProvider
  final filters = ref.watch(filtersProvider);

  // depending on mealsProvider
  return ref.watch(mealsProvider).where((m) {
    return m.isGlutenFree == filters[Filter.glutenFree] &&
        m.isLactoseFree == filters[Filter.lactoseFree] &&
        m.isVegetarian == filters[Filter.vegetarian] &&
        m.isVegan == filters[Filter.vegan];
  }).toList();
});
```


