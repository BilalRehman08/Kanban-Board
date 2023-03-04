import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/utils/colors.dart';

customDropDown(
    {required BuildContext context,
    required List items,
    required Map selectedItem,
    required void Function(Object?)? onChanged}) {
  return DropdownButton(
    style: const TextStyle(color: ColorUtils.primaryColor),
    value: selectedItem,
    dropdownColor: Theme.of(context).colorScheme.primary,
    items: items.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Text(item["name"]),
            Text(item["email"]),
          ],
        ),
      );
    }).toList(),
    onChanged: onChanged,
  );
}
