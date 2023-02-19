import 'package:cloud_firestore/cloud_firestore.dart';

class AccessToken {
  String? uid;
  String? accessToken;
  Timestamp? expiresIn;
  String? refreshToken;
  String? idToken;
  String? scope;
  String? tokenType;

  AccessToken({
    this.uid,
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.idToken,
    this.scope,
    this.tokenType,
  });

  bool get isExpired {
    if (expiresIn != null) {
      final now = Timestamp.now();
      if (now.seconds > expiresIn!.seconds) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  AccessToken.fromJson(Map<String, dynamic> json) {
    final now = Timestamp.now();
    final expire = json['expires_in'].runtimeType == Timestamp
        ? json['expires_in'].seconds
        : now.seconds + json['expires_in'];
    uid = json['uid'];
    accessToken = json['access_token'];
    expiresIn = Timestamp(expire, 0);
    refreshToken = json['refresh_token'];
    idToken = json['id_token'];
    scope = json['scope'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['refresh_token'] = refreshToken;
    data['id_token'] = idToken;
    data['scope'] = scope;
    data['token_type'] = tokenType;
    return data;
  }
}
