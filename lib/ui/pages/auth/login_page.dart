import 'package:email_client/ui/common/app_button.dart';
import 'package:email_client/ui/common/app_text_field.dart';
import 'package:email_client/ui/common/validators.dart';
import 'package:email_client/ui/pages/auth/notifiers/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_utils.dart';
import '../../common/text_with_action.dart';
import '../home/home.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _listener(AuthState? previous, AuthState next) {
    if (next is LoginAuthState) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        ),
        (route) => false,
      );
    } else if (next is ErrorAuthState) {
      AppUtils.showToast(
        context,
        next.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authProvider,
      _listener,
    );
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
              Builder(
                builder: (context) {
                  final state = ref.watch(authProvider);
                  return AppButton(
                    label: 'Login',
                    onTap: _onLogin,
                    loading: state is LoadingAuthState,
                  );
                },
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

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final email = _emailController.text;
      final password = _passwordController.text;
      await ref.read(authProvider.notifier).loginUser(
            email: email,
            password: password,
          );
    }
  }

  void _onRegisterTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const RegisterPage();
        },
      ),
    );
  }
}
