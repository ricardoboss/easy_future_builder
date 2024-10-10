# easy_future_builder

Provides a better `FutureBuilder` experience.

## Installation

```bash
flutter pub add easy_future_builder
```

## Usage

### `EasyFutureBuilder` widget

```dart
import 'package:easy_future_builder/easy_future_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return EasyFutureBuilder<String>(
      future: Future.value('Hello World!'),
      onData: (context, data) => Text(data),
      onLoading: (context) => const Text('Loading...'),
      onError: (context, error, stackTrace) => Text('Error: $error'),
    );
  }
}
```

### `thenBuild` extension

```dart
import 'package:easy_future_builder/easy_future_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Future.value('Hello World!').thenBuild(
      (context, data) => Text(data),
      onLoading: (context) => const Text('Loading...'),
      onError: (context, error, stackTrace) => Text('Error: $error'),
    );
  }
}
```

## License

MIT
