import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.router.dart';
import 'package:kanban_board_flutter/services/profile_services.dart';
import 'package:kanban_board_flutter/services/local_storage_services.dart';
import 'package:kanban_board_flutter/utils/dialogs.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../model/user_model.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth auth;
  FirebaseAuthenticationService({required this.auth});
  NavigationService navigationService = locator<NavigationService>();

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Dialogs.showLoadingDialog();

      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await ProfileServices.saveProfileToFireStore(
          name: name, email: email, uid: userCredential.user!.uid);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);

      locator<NavigationService>().pushNamedAndRemoveUntil(
        Routes.loginView,
      );
    } on FirebaseAuthException catch (e) {
      Dialogs.closeDialog();

      Dialogs.showInfoDialog(
        title: "Error",
        info: _getFirebaseAuthErrorMessage(e.code),
      );
    }
  }

  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      Dialogs.showLoadingDialog();

      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      // Save user details to shared preferences
      final UserModel user = UserModel(
        name: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
        id: userCredential.user!.uid,
      );
      // if (isRememberMe) {
      // }

      navigationService.pushNamedAndRemoveUntil(Routes.homeView);

      return user;
    } on FirebaseAuthException catch (e) {
      Dialogs.closeDialog();

      Dialogs.showInfoDialog(
        title: "Error",
        info: _getFirebaseAuthErrorMessage(e.code),
      );

      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog();
      await FirebaseAuth.instance.signOut();
      LocalStorageServices.clearLocalStorage();
      // Timer(const Duration(seconds: 1), () {
      navigationService.pushNamedAndRemoveUntil(Routes.loginView);
      // });
    } catch (e) {
      Dialogs.closeDialog();
      Dialogs.showInfoDialog(title: "Error", info: e.toString());
    }
  }

  String _getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-not-found':
        return 'The email address is not registered.';
      case 'email-already-in-use':
        return 'The email address is already in use.';
      case 'wrong-password':
        return 'The password is incorrect.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'operation-not-allowed':
        return 'Authentication with email and password is not enabled.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
