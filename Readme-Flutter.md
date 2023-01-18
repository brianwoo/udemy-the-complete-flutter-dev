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

# Loading an additional font
- Add to MaterialApp's ThemeData (fontFamily) - Global font setup
- Create an assets directory for images (e.g. assets/fonts) under the root of the project
- Add to pubspec.yaml

```yaml
# In Code:
return MaterialApp(
  title: 'Frivia',
  theme: ThemeData(
    fontFamily: 'ArchitectsDaughter',
  ),
  home: const MyHomePage(title: 'Flutter Demo Home Page'),
);

# pubspec.yaml
fonts:
  - family: ArchitectsDaughter
    fonts:
      - asset: assets/fonts/ArchitectsDaughter-Regular.ttf
```
<br>

# Container
- Occupies the entire area of its parent (when there is no child)
- But a Container only occupies the size of the child (when there is a child)
- Only one child
- Change its styling using decoration property
- Use double.infinity on width / height to maximize the size

<br>

# Column
- Main Axis (vertical, from top to bottom)
- MainAxisAlignment
  - properties: to config how widgets are aligned vertically,
- MainAxisSize
  - properties: to config how much space the column takes from parent.
  - by default, it takes up all the available space across the main axis.
- CrossAxisAlignment:  to config how widgets are aligned horizontally.
  - by default, it does NOT takes up all the available space across the cross axis. Use Sizedbox.expand() to take up the cross space

<br>

# Row
- Main Axis (horizontal, from left to right)
- MainAxisAlignment
  - properties: to config how widgets are aligned horizontally,
- MainAxisSize
  - properties: to config how much space the row takes from parent.
  - by default, it takes up all the available space across the main axis.
- CrossAxisAlignment:  to config how widgets are aligned vertically.
  - by default, it does NOT takes up all the available space across the cross axis. Use Sizedbox.expand() to take up the cross space

<br>

# SizedBox
- Put an invisible box to occupy empty space
- Handy to add extra space between column / row items
```dart
Column(
  children: [
    _trueButton(),
    SizedBox(height: _deviceHeight! * 0.01),
    _falseButton(),
  ],
),
```
<br>

# Spacer
- Takes up all the space between 2 widgets

<br>

# FittedBox
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

# SingleChildScrollView
- There are occasion where not all the widget in a Column can fit on the screen
- Wrap a Column with SingleChildScrollView scrollable
- Similarly, wrap a Row with scrollDirection: Axis.horizontal
- https://www.youtube.com/watch?v=neAn35cY8y0

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

# Provider
- State management - a mechanism to expose values
- A provider's child widgets can get and set global values
- One child widget can update a value (call notifyListeners()) and another widget (listening) will then see the changed value.
- 3 Steps:
  1. Define a Provider: have a class extends ChangeNotifier
  2. In a Parent's build(), have this ChangeNotifierProvider wrap around the child listener widgets (Remember: 1 widget above the listener widget)
    - 2a. Alternatively, use ChangeNotifierProvider.value() for already created Provider (e.g. nested providers). https://stackoverflow.com/questions/57335980/changenotifierprovider-vs-changenotifierprovider-value
  3. child listener widgets can now have access to provider to get/set values
```dart
// *** Step 1
class GamePageProvider extends ChangeNotifier {

  void setQuestions(List<Question> questions) {
    _questions = questions
    notifyListeners();  // notify all the subscribers for state change.
  }

  List<Question> getQuestions() {
    return _questions;
  }
}

// *** Step 2
class GamePage extends StatelessWidget {
  GamePageProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(),
      child: Listener1(), // child widgets have access to provider
    );
  }

  // Alternatively, use ChangeNotifierProvider.value()
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameItem[i],
      child: Listener2(), // child widgets have access to provider
    );
  }
  
  // *** Step 3
  class Listener1 extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
      final questions = Provider.of<GamePageProvider>(context).getQuestions();
      return ListQuestionsWidget(questions);

      // Alternatively, use Consumer - advantage: refresh only the enclosing widget      
    }

    void _setQuestions() {
      Provider.of<GamePageProvider>(context).setQuestions(questions);
    }
  }
  
```

# Consumer
- Same functionality as Provider, but when data refreshes, it only re-run the Consumer builder code.
- No listen: false functionality like in Provider.of()

```dart
  Consumer<CartProvider>(
    // this iconButton passed into the child will be passed
    // in to the builder method below (as a 3rd arg.)
    // In this case, the Badge needs a child widget
    child: IconButton(
      icon: Icon(Icons.shopping_basket),
      onPressed: () {},
    ),
    builder: (context, cart, iconBtn) => Badge(
      value: cart.itemCount.toString(),
      child: iconBtn!,
    ),
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
