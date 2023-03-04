import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/app/app.router.dart';
import 'package:kanban_board_flutter/services/auth_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  FirebaseAuthenticationService firebaseAuthenticationService =
      FirebaseAuthenticationService(
    auth: FirebaseAuth.instance,
  );
  bool isShowPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  NavigationService navigationService = locator<NavigationService>();
  navigateToLoginView() {
    navigationService.navigateTo(Routes.loginView);
  }

  registerUser() async {
    await firebaseAuthenticationService.registerUser(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
