# Generate a new Project (CLI)
```bash
flutter create [project_name]
```
<br>

# Add a new Dart / Flutter package
- go to https://pub.dev

<br>


# Basic Stateless Widget
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

# Basic Stateful Widget
- Stateful Widget contains:
  - A createState() method
  - An private state class created internally

- Set State
  - Use setState() to update the state in the State class
  - When setState() is called, the build() method is called to rebuild the UI.

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: HomePage(),
    );
  }
}

// Stateful Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

<br>

# Loading local images
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

# Loading network images
- Use NetworkImage()
```dart
Widget _coinImageWidget(String imgUrl) {
  return Container(
    height: _deviceHeight! * 0.15,
    width: _deviceWidth! * 0.15,
    decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage(imgUrl)),
    ),
  );
}
```
<br>


# Container
- Occupies the entire area of its parent (when there is no child)
- But a Container only occupies the size of the child (when there is a child)
- Only one child
- Change its styling using decoration property

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

# Center
- Put a widget in the center of the screen (or of parent)


# AppBar
 - Bar at the top of the screen

<br>

# ListView and ListTile
- Scollable list and pre-built tile for the ListView
- ListTile has title, subtitle, trailing, etc. properties
```dart
/***
Building a ListView using ListView constructor
*/
return ListView(
      children: [
        ListTile(
          title: Text(
            "Do Laundry",
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(
            Icons.check_box_outlined,
            color: Colors.red,
          ),
        ),
      ],
    );
```

```dart
/***
Building a ListView using the ListView.builder()
*/
return ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (BuildContext context, int index) {
    var task = Task.fromMap(tasks[index]);
    return ListTile(
      title: Text(task.content),
      ),
      subtitle: Text(task.timestamp.toString()),
      trailing: Icon(
        Icons.check_box_outline_blank_outlined),
        color: Colors.red,
      ),
    );
  },
);
```
<br>

# Floating Action Button
- Defined in Scaffold (property: floatingActionButton)
- Use child property to add an icon

<br>

# Show Dialog
```dart
showDialog(
  context: context,
  builder: (ctx) {
    return AlertDialog(
      title: const Text("Add New Task!"),
      content: TextField(
        onSubmitted: (value) {
          // ... save to db ...
          // db.save(_newTaskContent);
          Navigator.pop(context); // Closes the dialog
        },
        onChanged: (value) {
          _newTaskContent = value;
        },
      ),
    );
  },
);
```
 <br>

# FutureBuilder
- Is a Widget
- Takes a Future and a builder function
- When the Future is resolves, the builder function is called which returns a widget
```dart
return FutureBuilder(
  future: Hive.openBox("tasks"),
  builder: (ctx, snapshot) {
    if (snapshot.hasData) {
      return _tasksList(snapshot.data);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  },
);
```
<br>

# GestureDector
- To detect user input (e.g. property onTap, onDoubleTap, etc)

<br>

# Go to another page
- Use Navigator.push()

```dart
GestureDetector(
  onDoubleTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailsPage(),
    ),
  ),
)
```

<br>

# Get Device's height and width
```dart
_deviceHeight = MediaQuery.of(context).size.height;
_deviceWidth = MediaQuery.of(context).size.width;
```
<br>

# Native Code - ensureInitialized()
- Use WidgetsFlutterBinding.ensureInitialized() if the app needs to make native calls
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
```
<br>

# Animation
- Different ways to do Animations:
  - AnimatedWidget (Animated*)
  - Tweens (short for in-between) + TweenAnimationBuilder
  - Animation Controllers

```dart
/** 
AnimatedWidget
*/
Widget _circularAnimationButton() {
  return Center(
    child: GestureDetector(
      onTap: () {
        setState(() {
          _buttonRadius += _buttonRadius == 200 ? -100 : 100;
        });
      },
      child: AnimatedContainer(
        height: _buttonRadius,
        width: _buttonRadius,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        duration: Duration(seconds: 2),
        curve: Curves.bounceInOut,
        child: Center(child: Text("Animated Widget")),
      ),
    ),
  );
}
```

```dart
/**
Tween
*/

// Tween goes between 0 (nothing) -> 1 (full)
final Tween<double> _backgroundScale = Tween(begin: 0.0, end: 1.0);

Widget _pageBackground() {
  return TweenAnimationBuilder(
    curve: Curves.easeInOutCubicEmphasized,
    builder: (BuildContext context, double value, Widget? child) {
      return Transform.scale(
        scale: value,
        child: child,
      );
    },
    duration: const Duration(seconds: 1),
    tween: _backgroundScale,
    child: Container(color: Colors.blueAccent),
  );
}
```

```dart
/**
Animation Controller
*/
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  AnimationController? _starAnimController;

  @override
  void initState() {
    super.initState();
    _starAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _starAnimController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _starIcon(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starAnimController!.view,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _starAnimController!.value * 2 * pi, // in radian
          child: child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
```
