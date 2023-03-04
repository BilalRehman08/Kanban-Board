import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/utils/colors.dart';
import 'package:stacked_services/stacked_services.dart';

class Dialogs {
  static void showInfoDialog({required String title, required String info}) {
    if (StackedService.navigatorKey?.currentContext != null) {
      showDialog(
        context: StackedService.navigatorKey!.currentContext!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(info),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  static void showLoadingDialogWithValue(
      {required BuildContext context,
      required ValueListenable<double?> valueListenable}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => ValueListenableBuilder<double?>(
            valueListenable: valueListenable,
            builder: (context, percent, child) {
              return Center(
                child: CircularProgressIndicator(
                    backgroundColor: ColorUtils.greyColor,
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 10,
                    value: percent),
              );
            }));
  }

  static void showLoadingDialog() {
    if (StackedService.navigatorKey?.currentContext != null) {
      showDialog(
        context: StackedService.navigatorKey!.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  static void showExportDialog({
    required BuildContext context,
    required onExport,
  }) {
    int groupValue = 0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) =>
          StatefulBuilder(builder: (ctx, StateSetter setState) {
        return AlertDialog(
          title: const Text("Export projects"),
          content: Wrap(
            direction: Axis.vertical,
            children: [
              const Text("Which projects do you want to export?"),
              const SizedBox(height: 10),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value as int;
                      });
                    },
                  ),
                  const Text("own projects"),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value as int;
                      });
                    },
                  ),
                  const Text("team's projects"),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: onExport,
              child: const Text('Export'),
            ),
          ],
        );
      }),
    );
  }

  static void closeDialog() {
    if (StackedService.navigatorKey?.currentContext != null) {
      Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
    }
  }
}
