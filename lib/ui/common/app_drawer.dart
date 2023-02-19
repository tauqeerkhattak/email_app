import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/home/home.dart';
import '../pages/webview_page/webview_page.dart';
import 'app_button.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  void _onAddAccountPressed(BuildContext context, WidgetRef ref) {
    ref.read(homeProvider.notifier).setLoading();
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => WebviewPage(
          onAccessGranted: (code) async {
            await _onAccessGranted(code, ref);
          },
        ),
      ),
    );
  }

  Future<void> _onAccessGranted(String authCode, WidgetRef ref) async {
    await ref.read(homeProvider.notifier).saveAccessToken(authCode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: PhysicalModel(
        color: Colors.white,
        elevation: 8.0,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Container(
          width: size.width * 0.7,
          height: size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: [
                _buildAddAccountButton(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddAccountButton(BuildContext context, WidgetRef ref) {
    return AppButton(
      onTap: () => _onAddAccountPressed(context, ref),
      label: 'Add account',
    );
  }
}
