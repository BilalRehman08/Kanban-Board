import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/model/project_model.dart';
import 'package:kanban_board_flutter/model/user_model.dart';
import 'package:kanban_board_flutter/utils/dialogs.dart';

class ProjectService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final projectDownloadProgress = ValueNotifier<double?>(0);
  final projectsDownloadProgress = ValueNotifier<double?>(0);
  Future<void> addProject({
    required String name,
    required String description,
    required List<UserModel> users,
    required BuildContext context,
  }) async {
    Dialogs.showLoadingDialog();
    try {
      final project = ProjectModel(
          ownerUid: FirebaseAuth.instance.currentUser!.uid,
          ownerName: FirebaseAuth.instance.currentUser!.displayName!,
          name: name,
          description: description,
          users: users
              .map((UserModel user) =>
                  {"uid": user.id, "name": user.name, "email": user.email})
              .toList());
      final docRef =
          await firestore.collection("projects").add(project.toMap());
      await firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'myProjects': FieldValue.arrayUnion([docRef.id]),
      });
      for (UserModel user in users) {
        print(user.id);
        await firestore.collection("users").doc(user.id).update({
          'otherProjects': FieldValue.arrayUnion([docRef.id]),
        });
      }
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

  Future getAllProjects({
    required BuildContext context,
    required String key,
  }) async {
    List<ProjectModel> projects = [];
    List projectIds = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print(value.data()![key]);
      return value.data()![key];
    });
    if (projectIds.isNotEmpty) {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("projects")
          .where(FieldPath.documentId, whereIn: projectIds)
          .get();
      for (QueryDocumentSnapshot doc in query.docs) {
        ProjectModel data =
            ProjectModel.fromMap(doc.data() as Map<String, dynamic>);
        data.id = doc.id;
        projects.add(data);
      }
    }

    projects.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return projects;
  }
}
