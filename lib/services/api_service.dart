import 'dart:convert';
import 'dart:developer';

import 'package:email_client/exceptions/app_exception.dart';
import 'package:email_client/resources/constants.dart';
import 'package:email_client/services/base_service.dart';
import 'package:email_client/services/firestore_service.dart';
import 'package:http/http.dart' as http;

import '../models/access_token.dart';
import '../models/enums/mail_format.dart';
import '../models/mail_model.dart';
import '../models/messages_model.dart';
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
      await firebaseService.saveAccount(
        token: accessToken,
      );
    });
  }

  Future<AccessToken> refreshToken({required AccessToken token}) async {
    final uri = Uri.parse(ApiConstants.tokenEndpoint);
    final body = {
      'client_id': Constants.googleClientId,
      'client_secret': Constants.googleClientSecret,
      'grant_type': 'refresh_token',
      'refresh_token': token.refreshToken,
    };
    final response = await http.post(
      uri,
      body: body,
    );
    final json = jsonDecode(response.body);
    AccessToken updatedToken = AccessToken.fromJson(json);
    updatedToken.uid = token.uid;
    await firebaseService.updateToken(
      updatedToken,
    );
    return updatedToken;
  }

  Future<MessageModel?> loadEmails() async {
    return await safeActionWithValue(
      () async {
        AccessToken? accessToken = await firebaseService.getAccessToken();
        if (accessToken != null) {
          if (accessToken.isExpired) {
            accessToken = await refreshToken(token: accessToken);
          }
          final uri = Uri.parse(ApiConstants.gmailEndpoint);
          final headers = {
            'Authorization': 'Bearer ${accessToken.accessToken}',
          };
          final response = await http.get(
            uri,
            headers: headers,
          );
          final json = jsonDecode(response.body);
          final message = MessageModel.fromJson(json);
          return message;
        } else {
          log('No account found!');
          return null;
        }
      },
    );
  }

  Future<MailModel> loadMail(String mailId,
      [MailFormat format = MailFormat.full, String? metadataHeaders]) async {
    AccessToken? accessToken = await firebaseService.getAccessToken();
    if (accessToken != null) {
      if (accessToken.isExpired) {
        accessToken = await refreshToken(token: accessToken);
      }
      String query = '$mailId?format=${format.name}&';
      if (metadataHeaders != null) {
        query += 'metadataHeaders=$metadataHeaders';
      }
      final uri = Uri.parse('${ApiConstants.gmailEndpoint}/$query');
      final headers = {
        'Authorization': 'Bearer ${accessToken.accessToken}',
      };
      final response = await http.get(
        uri,
        headers: headers,
      );
      final rawJson = response.body;
      final mailModel = MailModel.fromRawJson(rawJson);
      return mailModel;
    } else {
      throw AppException(message: 'Access token is null!');
    }
  }
}
