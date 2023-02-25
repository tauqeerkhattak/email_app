import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/mail_model.dart';
import '../../../utils/app_utils.dart';
import '../../common/loader.dart';
import 'notifier/mail_page_notifier.dart';
import 'notifier/mail_page_states.dart';
import 'views/mail_web_view.dart';

final mailProvider =
    StateNotifierProvider.autoDispose<MailPageNotifier, MailPageState>(
  (ref) => MailPageNotifier(),
);

class MailPage extends ConsumerStatefulWidget {
  final String mailId;
  const MailPage({
    Key? key,
    required this.mailId,
  }) : super(key: key);

  @override
  ConsumerState<MailPage> createState() => _MailPageState();
}

class _MailPageState extends ConsumerState<MailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(mailProvider.notifier).loadMail(widget.mailId);
    });
  }

  void _listener(MailPageState? previous, MailPageState next) {
    if (next is ErrorMailPageState) {
      AppUtils.showToast(context, next.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mailProvider, _listener);
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final state = ref.watch(mailProvider);
    if (state is LoadingMailPageState) {
      return const Loader();
    } else if (state is ErrorMailPageState) {
      return _buildError();
    } else if (state is LoadedMailPageState) {
      final mail = ref.read(mailProvider.notifier).mail;
      if (mail != null) {
        return _buildMail(mail);
      } else {
        return _buildError();
      }
    } else {
      return const Loader();
    }
  }

  Widget _buildMail(MailModel mail) {
    return MailWebView(
      html: mail.payload.parts.last.body.data,
    );
  }

  Widget _buildError() {
    return const Center(
      child: Text(
        'Could not load email!',
      ),
    );
  }
}
