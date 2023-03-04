import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanban_board_flutter/model/user_model.dart';
import 'package:kanban_board_flutter/services/local_storage_services.dart';

class ProfileServices {
  static Future<void> saveProfileToFireStore(
      {required String name,
      required String email,
      required String uid}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {'name': name, 'email': email, 'myProjects': [], 'otherProjects': []});
  }

    static UserModel? getUserFromLocally() {
    final userData = LocalStorageServices.getString("user_data");
    if (userData != null) {
      return UserModel.fromMap(jsonDecode(userData));
    }
    return null;
  }

  static Future<void> saveUserLocally(UserModel user) async {
    final userData = jsonEncode(user.toJson());
    await LocalStorageServices.saveStringLocally("user_data", userData);
  }

  static Future<List<UserModel>> getAllProfiles() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value) {
      List<UserModel> users = [];
      for (var doc in value.docs) {
        if (doc.id != FirebaseAuth.instance.currentUser!.uid) {
          Map<String, dynamic> data = doc.data();
          data["id"] = doc.id;
          users.add(UserModel.fromMap(data));
        }
      }
      return users;
    });
  }
}
