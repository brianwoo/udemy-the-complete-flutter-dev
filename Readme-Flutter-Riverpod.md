# Riverpod - App-wide State Management

## Setup

### Installation:
```bash
flutter pub add flutter_riverpod
```

### Wrap App() in ProviderScope()
```dart
// main.dart
void main() {
  runApp(const ProviderScope(child: App()));
}
```

