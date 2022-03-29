import 'package:flutter/material.dart';
abstract class AppButtonStyle {
  final color = const Color(0xFF01b4e4);
  static final ButtonStyle linkButton = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Color(0xFF01b4e4)),
  textStyle: MaterialStateProperty.all(
  TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,)
  )
  );
}