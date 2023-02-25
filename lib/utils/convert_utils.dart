import 'dart:convert';

String base64ToNormal(String data) {
  final bytes = base64Decode(data);
  return utf8.decode(bytes);
}
