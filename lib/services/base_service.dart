import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class BaseService {
  Future<void> safeFunction(AsyncCallback callback) async {
    try {
      callback.call();
    } on FirebaseException catch (e) {
      log('Error: ${e.message}');
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<dynamic> safeActionWithValue(AsyncValueGetter callback) async {
    try {
      return await callback();
    } on FirebaseException catch (e) {
      log('Error: ${e.message}');
      return null;
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }
}
