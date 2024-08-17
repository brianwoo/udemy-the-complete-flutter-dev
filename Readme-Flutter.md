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

# Text
- Display a text on screen
```dart
// Some useful attributes
Text(
  meal.title,
  maxLines: 2,
  textAlign: TextAlign.center,
  softWrap: true,
  overflow: TextOverflow.ellipsis,
  style: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
),
```

<br>

# Images

## Loading local images
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

## Loading memory images
- Use MemoryImage()
```dart
// In conjunction with the dart transparent_image package
MemoryImage(kTransparentImage)
```
<br>

## Loading network images
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

## FadeInImage
- Image is faded in during loading
```dart
FadeInImage(
  placeholder: MemoryImage(kTransparentImage),
  image: NetworkImage(meal.imageUrl),
  // BoxFit.cover to make sure the image is not distorted
  // Image is covering within the bounds of the parent widget
  fit: BoxFit.cover,
  height: 200,
  width: double.infinity,
)
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
- Ways to get a Container to use all the space
  - Use double.infinity on width / height to maximize the size
  - Use Expanded()

<br>

# Expanded
- Creates a widget that expands a child of a Row, Column or Flex so that the child fills the available space along the flex widget's MAIN axis
- Useful when there is an overflow in using Row and Column

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

# Column (As Parent), ListView (As a Child) & Unbounded height error
- Flutter layout algorithm is a single-pass (to be efficient and save battery)
- A parent widget sets a boundary constraint, its child can request for a size within the constraint.
- PROBLEM: Column DOES NOT has this constraint, it allows its children to set a size and ListView asks for an infinite height.
- [Unbounded height/width - YouTube](https://www.youtube.com/watch?v=jckqXR5CrPI)
- SOLUTIONS:
  - Use Expanded or Flexible if we want ListView to take up the rest of the space
  - Use SizedBox if we want to control the size of the ListView
- Similar problem also happens in Row (As Parent), TextField (As a Child). Solution: Add Expanded to enclose TextField
  
<br>

# SizedBox
- SizedBox covers the total size of the enclosed components
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

# Stack / Positioned
- Stack is used to create a new layer on top of the screen (e.g. one widget on top of another widget)
- The first widget added to the Stack will first display on the screen, the second widget added will display on top of the first widget, so on and so forth
- Tips: Use Positioned() to control the placing of overlaying widget
```dart
Stack(
  children: [
    NetworkImage(meal.imageUrl),    
    Positioned(
      bottom: 0,
      left: 0,
      right: 50,
      child: Text(meal.title),
    ),
  ],
)
```
<br>

# Align
- Set relative alignment to the screen or another widget

<br>

# Center
- Put a widget in the center of the screen (or of parent)
- Center takes up entire area of its parent

<br>

# Button
- To customize the button style, use styleFrom()
  
```dart
ElevatedButton(
  onPressed: () {},
  child: Text("Answer 1"),
  style: ElevatedButton.styleFrom(...),
),
```

<br>

# Handling Input (TextField, etc)
- 2 ways of handling input
  1. Use onChanged on an input widget
  2. Use Controller, e.g. TextEditingController()
    - Make sure to call controller.dispose() in lifecycle dispose() which is only avail in StatefulWidget

<br>

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
```dart
SizedBox(
  height: 300,
  SingleChildScrollView(
    child: Column(
      children: [
        .....
      ],
    ),
  ),
),
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

```dart
showModalBottomSheet(
  isScrollControlled: true,    // This makes sure the keyboard does not block the dialog
  context: context,
  builder: (ctx) => NewExpense(addExpense),
);
```


 <br>

# GestureDector / InkWell
- To detect user input (e.g. property onTap, onDoubleTap, etc)

<br>

# Multi-page Navigation
## Go to another page (Push)
- Use Navigator.push() - Push a new page on stack
- Use Navigator.pushReplacement() - Push a new page to replace the current page

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
## Return from Push
- Use Navigator.pop() to return to previous page
```dart
Navigator.of(context).pop();
```
- Alternatively, can setup a PopScope to better handle pop
  - canPop: if set to FALSE, it will not pop even the back button (or back gesture) is pressed.
    - onPopInvoked callback will be called when back button is pressed (Android only), iOS onPopInvoked not called
    - onPopInvoked callback will be called when programmatically pop() is called (Android & iOS)
  - pop() accept an argument to pass back data to caller
    
```dart
PopScope(
  canPop: false,
  onPopInvoked: (didPop) {
    if (didPop) return;
    Navigator.of(context).pop({
      Filter.glutenFree: _glutenFreeFilterSet,
      Filter.lactoseFree: _lactoseFreeFilterSet,
      Filter.vegetarian: _vegetarianFilterSet,
      Filter.vegan: _veganFilterSet,
    });
  },
  child: ....

// Caller (push)
Navigator.of(context).push<Map<Filter, bool>>(
  MaterialPageRoute(builder: (context) {
    return const FiltersScreen();
  }),
).then((value) {
  // Value from pop returned from this async function.
  print(value);
});
```

<br>

# initState
1. SomeObject() - Class initialization code
2. SomeObject constructor executes - instance vars and methods are created
3. SomeObject was created and in memory
4. Flutter calls initState()
   
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

# Future & Stream
- A Future represents a computation that doesn’t complete immediately. Where a normal function returns the result, an asynchronous function returns a Future, which will eventually contain the result. The future will tell you when the result is ready.

- A stream is a sequence of asynchronous events. It is like an asynchronous Iterable-where, instead of getting the next event when you ask for it, the stream tells you that there is an event when it is ready.
<br>
<br>

# FutureBuilder & StreamBuilder
- Both StreamBuilder and FutureBuilder have the same behavior: They listen to changes on their respective object. And trigger a new build when they are notified of a new value.

- FutureBuilder is used for one time response, like taking an image from Camera, getting data once from native platform (like fetching device battery), getting file reference, making an http request etc.

- StreamBuilder is used for fetching some data more than once, like listening for location update, playing a music, stopwatch, etc.
```dart
  // Constructing FutureBuilder
  Widget _buildFutureBuilder() {
    return Center(
      child: FutureBuilder<int>(
        future: _calculateSquare(10),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return Text("Square = ${snapshot.data}");

          return CircularProgressIndicator();
        },
      ),
    );
  }

  // used by FutureBuilder
  Future<int> _calculateSquare(int num) async {
    await Future.delayed(Duration(seconds: 5));
    return num * num;
  }
```

```dart
  // Constructing StreamBuilder
  Widget _buildStreamBuilder() {
    return Center(
      child: StreamBuilder<int>(
        stream: _stopwatch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active)
            return Text("Stopwatch = ${snapshot.data}");

          return CircularProgressIndicator();
        },
      ),
    );
  }

  // used by StreamBuilder
  Stream<int> _stopwatch() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield _count++;
    }
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
<br>

# Isolate - Thread Support in Dart
- A Isolate has its own memory and not shared with another Isolate
- Isolate can communicate with another Isolate by SendPort/ReceivePort
- A SendPort is created from a ReceivePort
- Isolate.kill() can kill the isolate
- Cannot send Isolate via SendPort.send()
```dart
void main(List<String> args) {
  _createIsolate();
}

//***********************
// Main thread - also an Isolate
//***********************
Future _createIsolate() async {
  // Create an isolate
  ReceivePort rp = ReceivePort();
  Isolate.spawn(isolateFunc, rp.sendPort);

  // Get a SendPort from child
  // (so we send data in both dir)
  SendPort childSendPort = await rp.first;

  // Data port
  ReceivePort responsePort = ReceivePort();
  childSendPort.send([
    "random-data-api.com",
    "/api/v2/users",
    responsePort.sendPort,
  ]);

  final resp = await responsePort.first;
  print(resp['email']);

  return null;
}

//***********************
// Child Isolate
//***********************
void isolateFunc(SendPort mainSendPort) async {
  // Create a SendPort for the main Isolate
  // (so we send data in both dir)
  ReceivePort childReceivePort = ReceivePort();
  mainSendPort.send(childReceivePort.sendPort);

  await for (var msg in childReceivePort) {
    String url = msg[0];
    String path = msg[1];
    SendPort replyPort = msg[2];

    Uri uri = Uri.https(url, path);
    final resp = await http.get(uri);
    replyPort.send(jsonDecode(resp.body));
  }
}
```
<br>

# Compute Function - a Simplified Isolate
- Only works in Flutter, not Dart
- Callback function needs to be any of the following:
  - a top-level function
  - static method
  - closure
```dart
  Future<String> _startComputeFunc() async {
    String result = await compute(
      _longRunningFunc,
      {
        "host": "randomuser.me",
        "path": "/api",
      },
    );
    return result;
  }

  // static func as callback
  static Future<String> _longRunningFunc(Map<String, String> endpoint) async {
    final uri = Uri.https(endpoint['host']!, endpoint['path']!);
    final response = await http.get(uri);
    return jsonDecode(response.body)['results'][0]['email'];
  }

  // call _startComputeFunc() in a FutureBuilder()...
```

# Native 
```dart
// In main():
WidgetsFlutterBinding.ensureInitialized();
```
