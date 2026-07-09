import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// Shortcut for [Theme.of(context)].
  ThemeData get theme => Theme.of(this);

  /// Shortcut for [Theme.of(context).textTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Shortcut for [Theme.of(context).colorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Shortcut for [MediaQuery.of(context)].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Shortcut for [MediaQuery.sizeOf(context)].
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Shows a [SnackBar] with the given [message].
  ///
  /// Clears any currently visible snack bar before showing the new one.
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
