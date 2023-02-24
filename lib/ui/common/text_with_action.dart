import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TextWithAction extends StatelessWidget {
  final String label, actionLabel;
  final VoidCallback onTap;
  const TextWithAction({
    Key? key,
    required this.label,
    required this.actionLabel,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: label,
          style: AppTheme.appStyle(context).normal,
          children: [
            TextSpan(
              text: actionLabel,
              style: AppTheme.appStyle(context).action,
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
