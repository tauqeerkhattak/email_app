import 'package:flutter/material.dart';

import '../ui/theme/app_theme.dart';

class AppUtils {
  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar(context, message),
    );
  }

  static SnackBar _buildSnackBar(BuildContext context, String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: AppTheme.appColor(context).primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      behavior: SnackBarBehavior.floating,
      // width: 300,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
