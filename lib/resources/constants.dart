import 'api_constants.dart';

class Constants {
  static const googleClientId =
      '1042545178005-2dt0gmp1mblq9oivd37os4ks7folfn05.apps.googleusercontent.com';
  static const googleClientSecret = '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';
  static const _scopes = 'https://mail.google.com/';
  static final emailRegExp = RegExp(
      '/^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*\$/.');

  static Uri getGoogleUri() {
    String url = '${ApiConstants.authEndpoint}?';
    url += 'client_id=$googleClientId';
    url += '&redirect_uri=${ApiConstants.redirectUri}';
    url += '&scope=$_scopes';
    url += '&response_type=code';
    url += '&access_type=offline';
    url += '&prompt=consent';
    return Uri.parse(url);
  }
}
