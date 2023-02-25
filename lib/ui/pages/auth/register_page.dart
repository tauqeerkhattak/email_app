import 'dart:developer';

import 'package:email_client/ui/pages/auth/notifiers/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/app_button.dart';
import '../../common/app_text_field.dart';
import '../../common/text_with_action.dart';
import '../../common/validators.dart';
import '../home/home.dart';
import 'notifiers/auth_notifier.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  // @override
  // initState() {
  //   super.initState();
  //
  // }

  Future<void> _onRegister(WidgetRef ref) async {
    if (!formKey.currentState!.validate()) {
      log('Not validated!');
      return;
    } else {
      final email = emailController.text;
      final password = passwordController.text;
      final name = nameController.text;
      await ref.read(authProvider.notifier).registerUser(
            email: email,
            password: password,
            name: name,
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authProvider,
      (previous, next) {
        if (next is ErrorAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error),
            ),
          );
        } else if (next is RegisteredAuthState) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false,
          );
        }
      },
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                controller: nameController,
                hint: 'Name',
                prefix: Icons.person,
                validator: Validators.validator,
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                controller: emailController,
                hint: 'Email',
                prefix: Icons.email,
                validator: Validators.emailValidator,
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                controller: passwordController,
                hint: 'Password',
                prefix: Icons.password,
                validator: Validators.validator,
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(authProvider);
                  return AppButton(
                    onTap: () => _onRegister(ref),
                    label: 'Register',
                    loading: state is LoadingAuthState,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextWithAction(
                label: 'Already have an account? ',
                actionLabel: 'Login',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
