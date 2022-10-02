# Generate a new Project (CLI)
```bash
flutter create [project_name]
```
<br>

# Basic main.dart
```dart
void main() {
  runApp(const App());
}

class App extends StatelessWidget {

  const App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Title",
      home: Scaffold(
        body: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
```
<br>

# Loading images
- Use AssetImage class in code
- Create an assets directory for images (e.g. assets/images) under the root of the project
- Add to pubspec.yaml

```yaml
# pubspec.yaml

flutter:
  assets:
    - assets/images/my_image.png
    - assets/images/ # alternately just specify the dir
```
<br>

# Container
- Occupies the entire area of its parent (when there is no child)
- But a Container only occupies the size of the child (when there is a child)
- Only one child
- Change its styling using docoration property

<br>

# Column
- Main Axis (vertical, from top to bottom)
- MainAxisAlignment
  - properties: to config how widgets are aligned vertically,
- MainAxisSize
  - properties: to config how much space the column takes from parent.
- CrossAxisAlignment:  to config how widgets are aligned horizontally.

<br>

# Row
- Main Axis (horizontal, from left to right)
- MainAxisAlignment
  - properties: to config how widgets are aligned horizontally,
- MainAxisSize
  - properties: to config how much space the row takes from parent.
- CrossAxisAlignment:  to config how widgets are aligned vertically.

<br>

# Stack
- Stack is used to create a new layer on top of the screen (e.g. one widget on top of another widget)
- The first widget added to the Stack will first display on the screen, the second widget added will display on top of the first widget, so on and so forth

<br>

# Align
- Set relative alignment to the screen or another widget

<br>

# Get Device's height and width
```dart
_deviceHeight = MediaQuery.of(context).size.height;
_deviceWidth = MediaQuery.of(context).size.width;
```

<br>

