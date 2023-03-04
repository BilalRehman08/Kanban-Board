import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kanban_board_flutter/model/timer_model.dart';

class TimerService {
  Map<String, TimerModel> timers = {};

  void addTimer(String taskId) {
    timers[taskId] = TimerModel();
    timers[taskId]!.start = DateTime.now();
  }

  Future<void> stopTimer(String projectId, String taskId) async {
    DateTime endTime = DateTime.now();
    await sendDataToFirebase(
        projectId: projectId,
        taskId: taskId,
        start: timers[taskId]!.start!,
        end: endTime,
        duration: endTime.difference(timers[taskId]!.start!).inSeconds);
    timers.remove(taskId);
  }

  Future<void> sendDataToFirebase({
    required String projectId,
    required String taskId,
    required DateTime start,
    required DateTime end,
    required int duration,
  }) async {
    final docRef = FirebaseFirestore.instance
        .collection("projects")
        .doc(projectId)
        .collection("In-process")
        .doc(taskId);
    await docRef.collection("taskTimes").add({
      "start": start,
      "end": end,
      "duration": duration,
    });
    await docRef.update({
      "duration": FieldValue.increment(duration),
    });
  }
}
