# Form
- Form Widget is available
- Form input widgets which provide extra functionality than regular input widgets
  - E.g. TextFormField vs TextField
 
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
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
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField(
              items: categories.entries.map(....).toList(),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
```

## Validators
- if validator function:
  - Input value parameter fails validation, return a non-null string (as an error msg)
  - Input value parameter passes validation, return null
- Validator functions will be executed only when _formKey.currentState!.validate() is called
```dart

class _NewItemState extends ... {
  
  
  // Use GlobalKey to setup a key for the form.
  final _formKey = GlobalKey<FormState>();
  
  void _saveItem() {
    final isValidated = _formKey.currentState!.validate();

    if (isValidated) {
      _formKey.currentState!.save();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Name')),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().length <= 1 ||
            value.trim().length > 50) {
          return 'Must be between 1 to 50 chars.';
        }
        return null;
      },
    );
  
    // Save and validate
    ElevatedButton(
      onPressed: _saveItem,
      child: const Text('Add Item'),
    );
  
    // RESET the form
    TextButton(
      onPressed: () => _formKey.currentState!.reset(),
      child: const Text('Reset'),
    );
  
  }
}
```

