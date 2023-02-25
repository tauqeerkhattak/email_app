import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MailWebView extends StatefulWidget {
  final String html;
  const MailWebView({
    Key? key,
    required this.html,
  }) : super(key: key);

  @override
  State<MailWebView> createState() => _MailWebViewState();
}

class _MailWebViewState extends State<MailWebView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            preferredContentMode: UserPreferredContentMode.MOBILE,
          ),
        ),
        initialData: InAppWebViewInitialData(
          data: widget.html,
        ),
      ),
    );
  }
}
