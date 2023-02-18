import 'package:cloud_firestore/cloud_firestore.dart';

class AccessToken {
  String? accessToken;
  Timestamp? expiresIn;
  String? refreshToken;
  String? scope;
  String? tokenType;

  AccessToken({
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.scope,
    this.tokenType,
  });

  AccessToken.fromJson(Map<String, dynamic> json) {
    final now = Timestamp.now();
    accessToken = json['access_token'];
    expiresIn = Timestamp(now.seconds + (json['expires_in'] as int), 0);
    refreshToken = json['refresh_token'];
    scope = json['scope'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['refresh_token'] = refreshToken;
    data['scope'] = scope;
    data['token_type'] = tokenType;
    return data;
  }
}
