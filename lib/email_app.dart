import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ui/pages/auth/login_page.dart';
import 'ui/pages/home/home.dart';
import 'ui/theme/app_colors.dart';
import 'ui/theme/app_styles.dart';
import 'ui/theme/app_theme.dart';

class EmailApp extends StatelessWidget {
  EmailApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      color: AppColors(),
      style: AppStyles(),
      child: MaterialApp(
        home: _auth.currentUser != null ? const Home() : const LoginPage(),
      ),
    );
  }
}
