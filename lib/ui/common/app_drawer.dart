import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import '../../models/user_model.dart';
import '../../resources/constants.dart';
import '../../services/firestore_service.dart';
import '../../services/service_locator.dart';
import '../pages/home/home.dart';
import '../pages/webview_page/webview_page.dart';
import '../theme/app_theme.dart';
import 'app_button.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  Future<void> _onAddAccountPressed(BuildContext context, WidgetRef ref) async {
    ref.read(homeProvider.notifier).setLoading();
    if (kIsWeb) {
      await _openForWeb(ref);
    } else {
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
  }

  Future<void> _openForWeb(WidgetRef ref) async {
    final uri = Constants.getGoogleUri();
    final window = html.window.open(uri.toString(), 'Google Auth');
    final event = await html.window.onMessage.first;
    if (event.data != null) {
      final receivedUri = Uri.parse(event.data);

      final accessToken = receivedUri.queryParameters['accountId'];
      if (accessToken != null) {
        window?.close();
        await _onAccessGranted(accessToken, ref);
      }
    }
  }

  Future<void> _onAccessGranted(String authCode, WidgetRef ref) async {
    await ref.read(homeProvider.notifier).saveAccessToken(authCode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      key: const PageStorageKey('Drawer'),
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
                _buildName(),
                const Spacer(),
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

  Widget _buildName() {
    return FutureBuilder<UserModel?>(
      future: serviceGetter<FirebaseService>().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListTile(
            title: Center(
              child: Text(
                snapshot.data!.name,
                style: TextStyle(
                  color: AppTheme.appColor(context).primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
            subtitle: Center(
              child: Text(
                snapshot.data!.email,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
