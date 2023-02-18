import 'package:email_client/services/api_service.dart';
import 'package:email_client/services/base_notifier.dart';
import 'package:email_client/services/service_locator.dart';

import 'home_page_states.dart';

class HomePageNotifier extends BaseNotifier<HomePageState> {
  HomePageNotifier() : super(InitialHomePageState());
  final apiService = serviceGetter<ApiService>();

  @override
  void caughtError(String message) {
    state = ErrorHomePageState(message);
  }

  void setLoading() {
    state = LoadingHomePageState();
  }

  // Future<void> load

  Future<void> saveAccessToken(String authCode) async {
    await safeAction(() async {
      await apiService.getAccessToken(authCode);
      await apiService.loadEmails();
      state = LoadedHomePageState();
    });
  }
}
