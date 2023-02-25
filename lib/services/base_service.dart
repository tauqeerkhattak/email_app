import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class BaseService<T> {
  Future<void> safeFunction(AsyncCallback callback) async {
    try {
      callback.call();
    } on FirebaseException catch (e) {
      log(
        'FirebaseError: ${e.message}',
        stackTrace: e.stackTrace,
      );
    } catch (e, stack) {
      log(
        'Error: $e',
        stackTrace: stack,
      );
    }
  }

  Future<T?> safeActionWithValue<A>(AsyncValueGetter<T> callback) async {
    try {
      return await callback();
    } on FirebaseException catch (e) {
      log(
        'FirebaseError: ${e.message}',
        stackTrace: e.stackTrace,
      );
      return null;
    } catch (e, stack) {
      log(
        'Error: $e',
        stackTrace: stack,
      );
      return null;
    }
  }
}
