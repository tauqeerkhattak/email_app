import 'dart:developer';

import 'package:email_client/ui/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/messages_model.dart';
import '../../common/app_drawer.dart';
import '../../theme/app_theme.dart';
import '../mail/mail_page.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider.notifier).loadEmails();
    });
  }

  Widget _buildLoading() {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(homeProvider);
        if (state is LoadingHomePageState) {
          return const Loader();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        'Inbox',
        style: TextStyle(
          color: AppTheme.appColor(context).primary,
        ),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.dehaze,
              color: AppTheme.appColor(context).primary,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        _buildLoading(),
      ],
    );
  }

  Widget _buildBody() {
    final state = ref.watch(homeProvider);
    if (state is LoadedHomePageState) {
      final messages = ref.read(homeProvider.notifier).messages;
      return ListView(
        children: messages.map((message) {
          return _buildMessageItem(message);
        }).toList(),
      );
    } else if (state is NoAccountHomePageState) {
      return const Center(
        child: Text('No account exist, please add an account!'),
      );
    } else {
      return const Loader();
    }
  }

  Widget _buildMessageItem(Messages message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10.0,
        child: ListTile(
          onTap: () => _onMessageTap(message),
          title: Text('ID: ${message.id}'),
        ),
      ),
    );
  }

  void _onMessageTap(Messages message) {
    if (message.id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MailPage(
              mailId: message.id!,
            );
          },
        ),
      );
    } else {
      log('Message id is null!');
    }
  }
}
