import 'dart:convert';

import 'package:email_client/resources/constants.dart';
import 'package:email_client/services/base_service.dart';
import 'package:email_client/services/firestore_service.dart';
import 'package:http/http.dart' as http;

import '../models/access_token.dart';
import '../resources/api_constants.dart';
import 'service_locator.dart';

class ApiService extends BaseService {
  final firebaseService = serviceGetter<FirebaseService>();

  Future<void> getAccessToken(String authCode) async {
    await safeFunction(() async {
      final uri = Uri.parse(ApiConstants.tokenEndpoint);
      final body = {
        'client_id': Constants.googleClientId,
        'client_secret': Constants.googleClientSecret,
        'code': authCode,
        'grant_type': 'authorization_code',
        'redirect_uri': ApiConstants.redirectUri,
      };
      final response = await http.post(
        uri,
        body: body,
      );
      final json = jsonDecode(response.body);
      final accessToken = AccessToken.fromJson(json);
      await firebaseService.saveToken(accessToken);
    });
  }

  Future<void> loadEmails() async {
    await safeFunction(
      () async {
        final accessToken = await firebaseService.getAccessToken();
        if (accessToken != null) {}
      },
    );
  }
}
