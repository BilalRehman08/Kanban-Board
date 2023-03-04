import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/viewmodels/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
        viewModelBuilder: () => SplashViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 250,
                    width: 250,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
