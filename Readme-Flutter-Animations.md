# Animations
- Explicit Animations
  - You control the entire animation
  - More control but also more complexity
  - Can often be avoided (by using pre-built Wdigets)
- Implicit Animations
  - Flutter controls the animation
  - Less control and therefore less complexity
  - Use pre-built animation widgets as often as possible!
 

## Explicit Animations
### Boilerplate code setup

```dart
// Widget needs to be a StatefulWidget
class CategoriesScreen extends StatefulWidget {
...
}

// Need to add mixin:
//   SingleTickerProviderStateMixin - for single animation controller
//   TickerProviderStateMixin - for multiple animation controllers
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {

  // initState to instantiate a AnimationController
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      // animation goes from the value set by lowerBound to upperBound
      lowerBound: 0,
      upperBound: 1,
    );

    // start the animation
    _animationController.forward();

    // animation controller also has stop and repeat
    // _animationController.stop();
    // _animationController.repeat();

  }

  // dispose to avoid a memory leak
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

### Build & AnimatedBuilder
- For AnimatedBuilder, use XxxTransition and Curves.xxxx options for much better results
```dart
// Basic Example (Not optimized)
@override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      // XyzWidget is pre-setup to pass into the builder function (child arg)
      child: XyzWidget(),
      // builder function will be executed 60fps to output the animations
      // _animationController.value will go from 0 - 1, within 300ms (as we setup)
      // NOTE: Sliding up like this DOES NOT provide the smoothest experience
      // Use XxxTransition() instead.
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        child: child,
      ),
    );
  }

// SlideTransition Example (Optimized, use this)
@override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      // XyzWidget is pre-setup to pass into the builder function (child arg)
      child: XyzWidget(),
      // builder function will be executed 60fps to output the animations
      builder: (context, child) => SlideTransition(
        position: Tween(
          // offset: x,y (goes between 0 - 1)
          // 0.3 means 30%, and in the y axis (30% down)
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          // Curves provides different type of animation options
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInQuart,
          ),
        ),
        child: child,
      ),
    );
  }
```

<hr>
<br>

## Implicit Animations
- [Animated Widgets for Implicit Animations](https://docs.flutter.dev/ui/widgets/animation)

### Boilerplate code setup
```dart
@override
  Widget build(BuildContext context, WidgetRef ref) {

    return IconButton(
            onPressed: () { ... },
            // AnimatedSwitcher switches child
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: isFavorite
                  ? const Icon(Icons.star, key: ValueKey(0))
                  : const Icon(Icons.star_border, key: ValueKey(1)),
            ),
          );
}
```

