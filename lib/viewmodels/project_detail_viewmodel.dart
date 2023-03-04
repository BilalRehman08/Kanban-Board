import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/services/project_csv_export_services.dart';
import 'package:stacked/stacked.dart';
import 'package:kanban_board_flutter/services/file_services.dart';
import 'package:kanban_board_flutter/services/project_services.dart';
import 'package:kanban_board_flutter/utils/dialogs.dart';
import 'package:kanban_board_flutter/utils/snackbar.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import 'package:csv/csv.dart';

class ProjectDetailViewModel extends BaseViewModel {
  downloadProjectAsCSV(
      {required BuildContext context,
      required String projectId,
      required String fileName}) async {
    ProjectCSVExportServices projectExportCSVService =
        locator<ProjectCSVExportServices>();
    Dialogs.showLoadingDialogWithValue(
        context: context,
        valueListenable: projectExportCSVService.projectDownloadProgress);
    List<List> csvData =
        await projectExportCSVService.exportSingleProject(projectId);
    String csv = const ListToCsvConverter().convert(csvData);
    File file = await FileServices.exportCSV(csv: csv, fileName: fileName);
    SnackBars.showSnackBar(
        context: context,
        content: Text('CSV file downloaded to ${file.path}'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            OpenFilex.open(file.path);
          },
        ));
    Dialogs.closeDialog();
  }
}
