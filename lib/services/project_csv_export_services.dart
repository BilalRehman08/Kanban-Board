import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ProjectCSVExportServices {
  final projectDownloadProgress = ValueNotifier<double?>(0);
  final projectsDownloadProgress = ValueNotifier<double?>(0);
   Future<List<List>> exportSingleProject(String projectId) async {
    await Permission.storage.request();
    List<Map> data = [];
    final projectRef =
        FirebaseFirestore.instance.collection("projects").doc(projectId);
    projectDownloadProgress.value = null;
    DocumentSnapshot projectSnapshot = await projectRef.get();
    projectDownloadProgress.value = 0;
    Map projectData = projectSnapshot.data() as Map;
    List users = projectData.remove("users");
    bool isTasksAvailable = false;
    projectData["users_email"] = users.map((e) => e["email"]).join(", ");
    projectData["users_name"] = users.map((e) => e["name"]).join(", ");
    int noOfTotalTasks = projectData["completedTasksCount"] +
        projectData["inProgressTasksCount"] +
        projectData["todoTasksCount"];
    int noOfDonwloadTasks = 0;
    for (String taskType in ["toDo", "In-process", "Completed"]) {
      final projectTasks = await projectRef.collection(taskType).get();
      for (QueryDocumentSnapshot task in projectTasks.docs) {
        isTasksAvailable = true;
        Map taskData = task.data() as Map;
        Map assignedUser = taskData.remove("assignedTo");
        taskData["assignedTo_email"] = assignedUser["email"];
        taskData["assignedTo_name"] = assignedUser["name"];
        Map taskDataForCSV = {};
        taskDataForCSV.addAll(projectData);
        taskDataForCSV.addAll(taskData);
        data.add(taskDataForCSV);
        noOfDonwloadTasks++;
        projectDownloadProgress.value = noOfDonwloadTasks / noOfTotalTasks;
      }
    }
    if (!isTasksAvailable) {
      projectDownloadProgress.value = 1;
      data.add(projectData);
    }
    List<List> dataForCSV = [];
    dataForCSV.add(data.first.keys.toList());
    dataForCSV.addAll(data.map((e) => e.values.toList()));
    return dataForCSV;
  }

  Future<List<List>> exportAllProjects(String fieldKey) async {
    List<List> dataForCSV = [];
    projectsDownloadProgress.value = null;
    List projectIds = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.data()![fieldKey]);
    projectsDownloadProgress.value = 0;
    int noOfTotalProjects = projectIds.length;
    int noOfDonwloadProjects = 0;
    for (String projectId in projectIds) {
      dataForCSV.addAll(await exportSingleProject(projectId));
      noOfDonwloadProjects++;
      projectsDownloadProgress.value = noOfDonwloadProjects / noOfTotalProjects;
    }
    return dataForCSV;
  }
}