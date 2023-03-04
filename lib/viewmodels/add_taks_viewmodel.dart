import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/services/tasks_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTaksViewModel extends BaseViewModel {
  Map selectedUser = {};

  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  Future<void> addTask(
      {required String projectId, required BuildContext context}) async {
    TasksServices tasksServices = TasksServices(
      firestore: FirebaseFirestore.instance,
    );
    await tasksServices.addTask(
        projectId: projectId,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        taskAssignedTo: selectedUser,
        context: context);
    locator<NavigationService>().back();
  }
}
