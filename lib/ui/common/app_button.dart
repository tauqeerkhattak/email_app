import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool loading;
  const AppButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: AppTheme.appColor(context).primary,
        minimumSize: Size(
          MediaQuery.of(context).size.width,
          kBottomNavigationBarHeight,
        ),
      ),
      onPressed: onTap,
      child: loading
          ? CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                AppTheme.appColor(context).white,
              ),
            )
          : Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
    );
  }
}
