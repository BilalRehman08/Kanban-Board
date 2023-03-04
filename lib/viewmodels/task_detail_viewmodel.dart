import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class TaskDetailViewModel extends BaseViewModel {
  getTimerHistory(
      {required String projectId,
      required String taskId,
      required String status}) {
    return FirebaseFirestore.instance
        .collection("projects")
        .doc(projectId)
        .collection(status)
        .doc(taskId)
        .collection("taskTimes")
        .get();
  }
}
