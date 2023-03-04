import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board_flutter/services/tasks_services.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  group("Task Service -", () {
    group("Get All Tasks", () {
      test("Should return all Tasks", () async {
        String projectId = "12345678";
        String taskType = "Task 1";
        FirebaseFirestore firestore = MockFirebaseFirestore();
        CollectionReference<Map<String, dynamic>> collectionReference =
            MockCollectionReference();
        CollectionReference<Map<String, dynamic>> collectionReference2 =
            MockCollectionReference();
        DocumentReference<Map<String, dynamic>> documentReference =
            MockDocumentReference();
        QuerySnapshot<Map<String, dynamic>> querySnapshot = MockQuerySnapshot();
        Query<Map<String, dynamic>> query = MockQuery();
        when(firestore.collection("projects")).thenReturn(collectionReference);
        when(collectionReference.doc(projectId)).thenReturn(documentReference);
        when(documentReference.collection(taskType))
            .thenReturn(collectionReference2);
        when(collectionReference2.orderBy("createdAt", descending: true))
            .thenReturn(query);
        when(query.get()).thenAnswer((_) async => querySnapshot);
        TasksServices tasksServices = TasksServices(firestore: firestore);
        var result = await tasksServices.getAllTasks(
            projectId: projectId, taskType: taskType);
        expect(result, querySnapshot);
      });

      test("Should not return null if query returned successful results",
          () async {
        String projectId = "12345678";
        String taskType = "Task 1";
        FirebaseFirestore firestore = MockFirebaseFirestore();
        CollectionReference<Map<String, dynamic>> collectionReference =
            MockCollectionReference();
        CollectionReference<Map<String, dynamic>> collectionReference2 =
            MockCollectionReference();
        DocumentReference<Map<String, dynamic>> documentReference =
            MockDocumentReference();
        QuerySnapshot<Map<String, dynamic>> querySnapshot = MockQuerySnapshot();
        Query<Map<String, dynamic>> query = MockQuery();
        when(firestore.collection("projects")).thenReturn(collectionReference);
        when(collectionReference.doc(projectId)).thenReturn(documentReference);
        when(documentReference.collection(taskType))
            .thenReturn(collectionReference2);
        when(collectionReference2.orderBy("createdAt", descending: true))
            .thenReturn(query);
        when(query.get()).thenAnswer((_) async => querySnapshot);
        TasksServices tasksServices = TasksServices(firestore: firestore);
        var result = await tasksServices.getAllTasks(
            projectId: projectId, taskType: taskType);
        expect(result, isNotNull);
      });
    });
  });
}
