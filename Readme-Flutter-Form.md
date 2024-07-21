# Form
- Form Widget is available
- Form input widgets which provide extra functionality than regular input widgets
  - E.g. TextFormField vs TextField
 
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Name')),
              validator: (value) {
                return 'error';
              },
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Quantity')),
              initialValue: '1',
            ),
            DropdownButtonFormField(
              items: categories.entries
                      .map(....).toList(),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
```
