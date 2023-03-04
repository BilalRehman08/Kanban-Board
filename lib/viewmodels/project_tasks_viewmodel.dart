import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/app/app.router.dart';
import 'package:kanban_board_flutter/services/tasks_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectTasksViewModel extends BaseViewModel {
  final TasksServices _tasksServices = TasksServices(
    firestore: FirebaseFirestore.instance,
  );

  getToDoTasks(projectId) {
    return _tasksServices.getAllTasks(projectId: projectId, taskType: "toDo");
  }

  getInProgressTasks(projectId) {
    return _tasksServices.getAllTasks(
        projectId: projectId, taskType: "In-process");
  }

  getCompletedTasks(projectId) {
    return _tasksServices.getAllTasks(
        projectId: projectId, taskType: "Completed");
  }

  navigateToAddTasksView(projectId, users) async {
    await locator<NavigationService>().navigateTo(Routes.addTasksView,
        arguments: AddTasksViewArguments(projectId: projectId, users: users));
  }

  Future<void> goToInprocess(
      {required String taskId,
      required BuildContext context,
      required String status,
      required String projectId}) async {
    await _tasksServices.moveTaskAlongProjectCollection(
        taskId: taskId,
        status: status,
        context: context,
        countKeyForIncrement: "inProgressTasksCount",
        countKeyForDecrement: "todoTasksCount",
        projectId: projectId,
        fromCollection: "toDo",
        toCollection: "In-process");
  }

  Future<void> markAsCompleted(
      {required String taskId,
      required BuildContext context,
      required String status,
      required String projectId}) async {
    await _tasksServices.moveTaskAlongProjectCollection(
        taskId: taskId,
        status: status,
        context: context,
        projectId: projectId,
        countKeyForIncrement: "completedTasksCount",
        countKeyForDecrement: "inProgressTasksCount",
        toCollection: "Completed",
        fromCollection: "In-process");
  }
}
