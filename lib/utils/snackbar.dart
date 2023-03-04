import 'package:flutter/material.dart';

class SnackBars {
  static void showSnackBar({required BuildContext context, required Widget content, SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        action: action,
      ),
    );
  }
}