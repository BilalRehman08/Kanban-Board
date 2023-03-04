import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/dialogs.dart';

class TasksServices {
  FirebaseFirestore firestore;
  TasksServices({required this.firestore});
  getAllTasks({required String projectId, required String taskType}) {
    return firestore
        .collection('projects')
        .doc(projectId)
        .collection(taskType)
        .orderBy("createdAt", descending: true)
        .get();
  }

  addTask(
      {required String projectId,
      required String taskName,
      required String taskDescription,
      required Map taskAssignedTo,
      required BuildContext context}) async {
    Dialogs.showLoadingDialog();
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectId)
          .collection('toDo')
          .add({
        'title': taskName,
        'description': taskDescription,
        'createdAt': FieldValue.serverTimestamp(),
        'assignedTo': taskAssignedTo,
        'status': 'toDo',
        'duration': 0,
      });
      await FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .update({
        "todoTasksCount": FieldValue.increment(1),
      });
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  moveTaskAlongProjectCollection(
      {required String taskId,
      required String projectId,
      required String status,
      required BuildContext context,
      required String countKeyForIncrement,
      required String countKeyForDecrement,
      required String fromCollection,
      required String toCollection}) async {
    final projectRef =
        FirebaseFirestore.instance.collection('projects').doc(projectId);
    Dialogs.showLoadingDialog();
    await projectRef
        .collection(fromCollection)
        .doc(taskId)
        .update({'status': status});
    final docRef = projectRef.collection(fromCollection).doc(taskId);
    final docData = await docRef.get();
    final timerHistoryData = await docRef.collection('taskTimes').get();
    await projectRef.collection(toCollection).doc(taskId).set(docData.data()!);
    timerHistoryData.docs.forEach((element) async {
      await projectRef
          .collection(toCollection)
          .doc(taskId)
          .collection('taskTimes')
          .add(element.data());
    });
    await projectRef.collection(fromCollection).doc(taskId).delete();
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(projectId)
        .update({
      countKeyForIncrement: FieldValue.increment(1),
    });
    await FirebaseFirestore.instance
        .collection("projects")
        .doc(projectId)
        .update({
      countKeyForDecrement: FieldValue.increment(-1),
    });
    Dialogs.closeDialog();
  }
}
