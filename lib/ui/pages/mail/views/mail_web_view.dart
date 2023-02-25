import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadHtmlString(widget.html);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
