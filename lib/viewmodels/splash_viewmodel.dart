import 'dart:async';
import 'package:kanban_board_flutter/services/profile_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import '../app/app.router.dart';

class SplashViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  SplashViewModel() {
    Timer(const Duration(seconds: 3), () {
      checkLoggedIn();
    });
  }

  void checkLoggedIn() {
    final isLoggedIn = ProfileServices.getUserFromLocally();
    if (isLoggedIn != null) {
      navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    } else {
      navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    }
  }
}
