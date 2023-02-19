import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../resources/api_constants.dart';
import '../../../resources/constants.dart';

class WebviewPage extends StatefulWidget {
  final ValueSetter<String> onAccessGranted;
  const WebviewPage({
    Key? key,
    required this.onAccessGranted,
  }) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _controller = WebViewController()
      ..setUserAgent('Mozilla/5.0 (X11; Linux x86_64)')
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.contains(ApiConstants.redirectUri)) {
              final uri = Uri.parse(request.url);
              final accessToken = uri.queryParameters['code'] as String;
              log('Params: ${uri.queryParameters}');
              widget.onAccessGranted.call(accessToken);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(
        Constants.getGoogleUri(),
      );
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
