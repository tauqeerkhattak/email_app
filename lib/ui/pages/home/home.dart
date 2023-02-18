import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/app_button.dart';
import '../../theme/app_theme.dart';
import '../webview_page/webview_page.dart';
import 'notifiers/home_page_notifier.dart';
import 'notifiers/home_page_states.dart';

final homeProvider =
    StateNotifierProvider.autoDispose<HomePageNotifier, HomePageState>(
  (ref) => HomePageNotifier(),
);

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  void _onAddAccountPressed() {
    ref.read(homeProvider.notifier).setLoading();
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => WebviewPage(
          onAccessGranted: _onAccessGranted,
        ),
      ),
    );
  }

  Future<void> _onAccessGranted(String authCode) async {
    await ref.read(homeProvider.notifier).saveAccessToken(authCode);
  }

  Widget _buildLoading() {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(homeProvider);
        if (state is LoadingHomePageState) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                AppTheme.appColor(context).primary,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          _buildLoading(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppButton(
            onTap: _onAddAccountPressed,
            label: 'Add account',
          ),
        ],
      ),
    );
  }
}
