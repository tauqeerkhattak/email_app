import 'package:flutter/material.dart';

import '../../exceptions/app_exception.dart';
import 'app_colors.dart';

class AppTheme extends InheritedWidget {
  final AppColors color;
  const AppTheme({
    super.key,
    required this.color,
    required super.child,
  });

  static AppTheme? _maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>();
  }

  static AppTheme _of(BuildContext context) {
    final theme = _maybeOf(context);
    if (theme == null) {
      throw AppException(message: 'No theme is given uptree!');
    }
    return theme;
  }

  static AppColors appColor(BuildContext context) {
    return _of(context).color;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return oldWidget.color != color;
  }
}
