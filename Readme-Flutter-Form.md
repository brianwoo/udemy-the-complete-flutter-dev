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
- Validator function:
  - If input value parameter fails validation, return a non-null string (as an error msg)
  - If input value parameter passes validation, return null
- validator functions will be executed only when _formKey.currentState!.validate() is called
- onSaved functions will be executed only when _formKey.currentState!.save() is called
```dart

class _NewItemState extends ... {
  
  
  // Use GlobalKey to setup a key for the form.
  final _formKey = GlobalKey<FormState>();
  late String? _enteredName;
  
  void _saveItem() {
    // triggers validator function to be called
    final isValidated = _formKey.currentState!.validate();

    if (isValidated) {
      // triggers onSave function to be called
      _formKey.currentState!.save();
    }

    print(_enteredName);
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Name')),
      onSaved: (newValue) => _enteredName = newValue,
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

