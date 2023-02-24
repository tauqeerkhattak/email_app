import 'package:email_client/ui/common/app_button.dart';
import 'package:email_client/ui/common/app_text_field.dart';
import 'package:email_client/ui/common/validators.dart';
import 'package:flutter/material.dart';

import '../../common/text_with_action.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                controller: _emailController,
                validator: Validators.emailValidator,
                hint: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                controller: _passwordController,
                validator: Validators.validator,
                hint: 'Password',
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                label: 'Login',
                onTap: _onLogin,
              ),
              const SizedBox(
                height: 20,
              ),
              TextWithAction(
                label: 'Don\'t have an account? ',
                actionLabel: 'Register',
                onTap: _onRegisterTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      return;
    } else {}
  }

  void _onRegisterTap() {}
}
