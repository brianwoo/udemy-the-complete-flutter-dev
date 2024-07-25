# Http Requests to Firebase
- [Http package](https://pub.dev/packages/http/install)
- Alternatively [Dio package](https://pub.dev/packages/dio)

## POST Request
```dart
import 'package:http/http.dart' as http;

http.post(
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
