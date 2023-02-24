import 'package:flutter/material.dart';

import '../../exceptions/app_exception.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme extends InheritedWidget {
  final AppColors color;
  final AppStyles style;
  const AppTheme({
    super.key,
    required this.color,
    required this.style,
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

  static AppStyles appStyle(BuildContext context) {
    return _of(context).style;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return oldWidget.color != color;
  }
}
