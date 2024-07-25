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
