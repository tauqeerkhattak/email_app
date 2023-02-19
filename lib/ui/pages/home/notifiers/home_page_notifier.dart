import 'dart:developer';

import 'package:email_client/services/api_service.dart';
import 'package:email_client/services/base_notifier.dart';
import 'package:email_client/services/service_locator.dart';

import '../../../../models/messages_model.dart';
import 'home_page_states.dart';

class HomePageNotifier extends BaseNotifier<HomePageState> {
  HomePageNotifier() : super(InitialHomePageState());
  final apiService = serviceGetter<ApiService>();
  List<Messages> messages = [];

  @override
  void caughtError(String message) {
    state = ErrorHomePageState(message);
  }

  void setLoading() {
    state = LoadingHomePageState();
  }

  Future<void> loadEmails() async {
    state = LoadingHomePageState();
    final model = await apiService.loadEmails();
    if (model != null) {
      log('LENGTH: ${model.messages?.length}');
      messages = model.messages ?? [];
      state = LoadedHomePageState();
    } else {
      state = NoAccountHomePageState();
    }
  }

  Future<void> saveAccessToken(String authCode) async {
    await safeAction(() async {
      await apiService.getAccessToken(authCode);
      final model = await apiService.loadEmails();
      if (model != null) {
        messages = model.messages ?? [];
        state = LoadedHomePageState();
      } else {
        state = NoAccountHomePageState();
      }
    });
  }
}
