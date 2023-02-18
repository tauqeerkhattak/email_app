import '../../resources/constants.dart';

class Validators {
  static String? emailValidator(String? email) {
    if (email == null || email == '') {
      return 'Field cannot be null!';
    } else if (Constants.emailRegExp.hasMatch(email)) {
      return 'Enter a valid email!';
    } else {
      return null;
    }
  }

  static String? validator(String? value) {
    if (value == null || value == '') {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }
}
