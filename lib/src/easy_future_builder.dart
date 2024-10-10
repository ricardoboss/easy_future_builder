import 'package:flutter/material.dart';

/// A function that builds a widget using [data].
typedef FutureDataWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T? data,
);

/// A function that builds a widget based on an error object and a stack trace.
typedef FutureErrorWidgetBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace stackTrace,
);

/// A widget that builds a widget based on the state of a [Future].
///
/// Like [FutureBuilder], it can be used to build a widget based on the state
/// of a [Future]. However, it provides a more concise syntax and a more
/// intuitive API.
///
/// The [future] argument is required. It must be a [Future] that completes
/// with a value of type `T`.
///
/// The [onData] argument is optional. It must be a function that takes a
/// [BuildContext] and a value of type `T` and returns a widget. If the [future]
/// completes with a value, the [onData] builder is called with that value.
///
/// The [onLoading] argument is optional. It must be a function that takes a
/// [BuildContext] and returns a widget. If the [future] is still pending, the
/// [onLoading] builder is used.
///
/// The [onError] argument is optional. It must be a function that takes a
/// [BuildContext], an error object, and a stack trace, and returns a widget.
///
/// By default, each of the [onData] and [onLoading] builders return a
/// [SizedBox.shrink] widget. The [onError] builder returns a [ErrorWidget]
/// widget.
class EasyFutureBuilder<T> extends StatelessWidget {
  /// Creates a widget that builds a widget based on the state of a [Future].
  const EasyFutureBuilder({
    required this.future,
    super.key,
    this.onData,
    this.onLoading,
    this.onError,
  });

  /// The [Future] whose state will be used to build the widget.
  final Future<T> future;

  /// The builder to use when the [future] completes with a value.
  final FutureDataWidgetBuilder<T>? onData;

  /// The builder to use when the [future] is still pending.
  final WidgetBuilder? onLoading;

  /// The builder to use when the [future] completes with an error.
  final FutureErrorWidgetBuilder? onError;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, AsyncSnapshot<T> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
      case ConnectionState.active:
        return _onLoading(context);
      case ConnectionState.done:
        return _onDone(context, snapshot);
    }
  }

  Widget _onLoading(BuildContext context) {
    if (onLoading != null) {
      return onLoading!(context);
    }

    return const SizedBox.shrink();
  }

  Widget _onDone(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) {
      return _onError(context, snapshot.error!, snapshot.stackTrace!);
    }

    return _onData(context, snapshot.data);
  }

  Widget _onError(BuildContext context, Object error, StackTrace stackTrace) {
    if (onError != null) {
      return onError!(context, error, stackTrace);
    }

    return ErrorWidget(error);
  }

  Widget _onData(BuildContext context, T? data) {
    if (onData != null) {
      return onData!(context, data);
    }

    return const SizedBox.shrink();
  }
}
