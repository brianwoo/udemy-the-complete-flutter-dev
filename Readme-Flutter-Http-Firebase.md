# Http Requests to Firebase
- [Http package](https://pub.dev/packages/http/install)
- Alternatively [Dio package](https://pub.dev/packages/dio)

## POST Request
```dart
import 'package:http/http.dart' as http;

final url = Uri.https(
  'flutter-prep-12345-default-rtdb.firebaseio.com',
  'shopping-list.json',
);

final response = await http.post(
  url,
  headers: {
    'Content-Type': 'application/json',
  },
  body: json.encode(
    {
      'name': _enteredName,
      'quantity': int.parse(_enteredQuantity),
      'category': categories[_selectedCategory]!.title,
    },
  ),
);
```

## GET Request
```dart
final response = await http.get(url);

Map<String, dynamic> listData = jsonDecode(response.body);

```

## DELETE Request
```dart
final response = await http.delete(url);
```

## FutureBuilder with GET
```dart
Future<List<GroceryItem>> _loadItems() async {

  // if there is no network connection, get() will throw an exception
  final response = await http.get(url);

  // if we get a 4xx error, we throw an Exception, FutureBuilder's snapshot.hasError
  // will be true.
  if (response.statusCode >= 400) {
    throw Exception('Failed to fetch grocery items. Please try again later.');
  }

  final listData = jsonDecode(response.body);
  // ... Turn listData into List<GroceryItem> ...
  return loadedItems;
}


@override
Widget build(BuildContext context) {
  return FutureBuilder(
    // _loadItems() returns a Future or an Exception
    future: _loadItems(),
    builder: (context, snapshot) {
      // Still waiting for response...
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        // snapshot.error will return the error from the Exception
        return Center(child: Text(snapshot.error.toString()));
      }

      if (snapshot.data!.isEmpty) {
        return const Center(child: Text('Your Grocery List is Empty'));
      }

      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final itemList = snapshot.data!;

          return Dismissible(
            key: Key(itemList[index].id),
            onDismissed: (direction) => _deleteItem(itemList[index]),
            child: ListTile(
              leading: Container(
                height: 16,
                width: 16,
                color: itemList[index].category.color,
              ),
              title: Text(itemList[index].name),
              trailing: Text(itemList[index].quantity.toString()),
            ),
          );
        },
      );
    },
  );
}
```

