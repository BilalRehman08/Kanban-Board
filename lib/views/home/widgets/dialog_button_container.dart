import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/utils/colors.dart';

Container dialogButtonContainer({
  required String title,
  required Color color,
  VoidCallback? press,
}) {
  return Container(
    height: 40,
    width: 80,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
        onPressed: press,
        child: Text(
          title,
        )),
  );
}
