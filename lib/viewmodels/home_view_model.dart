import 'dart:io';

import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kanban_board_flutter/services/file_services.dart';
import 'package:kanban_board_flutter/services/project_csv_export_services.dart';
import 'package:kanban_board_flutter/services/project_services.dart';
import 'package:kanban_board_flutter/utils/dialogs.dart';
import 'package:kanban_board_flutter/utils/snackbar.dart';
import 'package:open_filex/open_filex.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../services/auth_services.dart';

class HomeViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  FirebaseAuthenticationService authService = FirebaseAuthenticationService(
    auth: FirebaseAuth.instance,
  );
  ProjectService projectService = ProjectService();
  ProjectCSVExportServices projectExportCSVService =
      locator<ProjectCSVExportServices>();
  final formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int exportRadioValue = 0;

  void navigateToProjectView(String projectId, List users, String ownerUid) {
    navigationService.navigateTo(
      Routes.projectTasksView,
      arguments: ProjectTasksViewArguments(
          projectId: projectId, users: users, ownerUid: ownerUid),
    );
  }

  getMyProjects({required BuildContext context}) async {
    var result = await projectService.getAllProjects(
        context: context, key: "myProjects");
    rebuildUi();
    return result;
  }

  getOtherProjects({required BuildContext context}) async {
    var result = await projectService.getAllProjects(
        context: context, key: "otherProjects");
    rebuildUi();
    return result;
  }

  signOutAndClearStorage({required BuildContext context}) async {
    scaffoldkey.currentState!.closeDrawer();
    await authService.signOut(context);
  }

  onExportProjects(context) async {
    Navigator.pop(context);
    Dialogs.showLoadingDialogWithValue(
        context: context,
        valueListenable:
            locator<ProjectCSVExportServices>().projectsDownloadProgress);
    List<List> csvData = await projectExportCSVService.exportAllProjects(
        exportRadioValue == 0 ? "myProjects" : "otherProjects");
    String csv = const ListToCsvConverter().convert(csvData);
    File file = await FileServices.exportCSV(
        csv: csv,
        fileName: exportRadioValue == 0 ? 'own_projects' : 'team_projects');
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
