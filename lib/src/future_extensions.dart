import 'package:easy_future_builder/easy_future_builder.dart';
import 'package:flutter/widgets.dart';

/// An extension method for [Future] that returns an [EasyFutureBuilder].
extension FutureExtension<T> on Future<T> {
  /// Returns an [EasyFutureBuilder] that builds a widget based on the state of
  /// this [Future].
  EasyFutureBuilder<T> thenBuild({
    FutureDataWidgetBuilder<T>? onData,
    WidgetBuilder? onLoading,
    FutureErrorWidgetBuilder? onError,
  }) {
    return EasyFutureBuilder<T>(
      future: this,
      onData: onData,
      onLoading: onLoading,
      onError: onError,
    );
  }
}
