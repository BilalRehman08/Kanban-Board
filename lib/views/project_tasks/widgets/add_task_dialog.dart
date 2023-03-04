import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/colors.dart';
import '../../home/widgets/dialog_button_container.dart';

AlertDialog AddTaskdialog(BuildContext context) {
  return AlertDialog(
    title: Text(AppLocalizations.of(context)!.addTask),
    content: TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: AppLocalizations.of(context)!.taskName),
    ),
    actions: [
      dialogButtonContainer(
          title: AppLocalizations.of(context)!.cancel,
          color: ColorUtils.redColor,
          press: () {
            Navigator.pop(context);
          }),
      dialogButtonContainer(
        title: AppLocalizations.of(context)!.add,
        color: ColorUtils.greenColor,
        press: () async {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
