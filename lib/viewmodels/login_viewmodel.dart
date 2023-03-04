import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/model/user_model.dart';
import 'package:kanban_board_flutter/services/auth_services.dart';
import 'package:stacked/stacked.dart';

import '../services/profile_services.dart';

class LoginViewModel extends BaseViewModel {
  FirebaseAuthenticationService authService = FirebaseAuthenticationService(
    auth: FirebaseAuth.instance,
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = false;
  bool isRememberMe = false;

  void onRememberMeChanged(bool value) {
    isRememberMe = value;
    rebuildUi();
  }

  loginUser({required BuildContext context}) async {
    UserModel? user = await authService.loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (user != null) {
      ProfileServices.saveUserLocally(user);
    }
  }
}
