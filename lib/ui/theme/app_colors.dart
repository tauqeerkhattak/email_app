import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppColors extends Equatable {
  final primary = Colors.purple;
  final secondary = Colors.cyanAccent;
  final white = Colors.white60;

  @override
  List<Color> get props => [
        primary,
        secondary,
      ];
}
