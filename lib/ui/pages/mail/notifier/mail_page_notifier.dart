import 'package:email_client/services/api_service.dart';
import 'package:email_client/services/base_notifier.dart';
import 'package:email_client/services/service_locator.dart';

import '../../../../models/mail_model.dart';
import 'mail_page_states.dart';

class MailPageNotifier extends BaseNotifier<MailPageState> {
  final apiService = serviceGetter<ApiService>();
  MailModel? mail;
  MailPageNotifier() : super(InitialMailPageState());

  @override
  void caughtError(String message) {
    state = ErrorMailPageState(message);
  }

  Future<void> loadMail(String mailId) async {
    await safeAction(
      () async {
        state = LoadingMailPageState();
        final mail = await apiService.loadMail(mailId);
        this.mail = mail;
        state = LoadedMailPageState();
      },
    );
  }
}
