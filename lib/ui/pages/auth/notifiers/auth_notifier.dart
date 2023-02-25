import 'package:email_client/services/firestore_service.dart';

import '../../../../services/base_notifier.dart';
import '../../../../services/service_locator.dart';
import 'auth_states.dart';

class AuthNotifier extends BaseNotifier<AuthState> {
  AuthNotifier() : super(InitialAuthState());
  final firebaseService = serviceGetter<FirebaseService>();

  @override
  void caughtError(String message) {
    state = ErrorAuthState(message);
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    await safeAction(() async {
      state = LoadingAuthState();
      await firebaseService.registerUser(
        email: email,
        password: password,
        name: name,
      );
      state = RegisteredAuthState();
    });
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await safeAction(() async {
      state = LoadingAuthState();
      await firebaseService.loginUser(
        email: email,
        password: password,
      );
      state = LoginAuthState();
    });
  }
}
