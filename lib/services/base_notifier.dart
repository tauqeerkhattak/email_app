import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseNotifier<T> extends StateNotifier<T> {
  BaseNotifier(super.state);

  void caughtError(String message);

  Future<void> safeAction(AsyncCallback callback) async {
    try {
      await callback.call();
    } on FirebaseException catch (e) {
      log(e.message ?? 'Error');
      caughtError(e.message ?? 'Error');
    } catch (e) {
      log('Error: $e');
      caughtError('$e');
    }
  }
}
