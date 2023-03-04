import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/services/auth_services.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  group("Auth Service -", () {
    group("login -", () {
      test(
          "Should return the same email that user logged in with if login was successful",
          () async {
        WidgetsFlutterBinding.ensureInitialized();
        // await LocalStorageServices.init();

        if (locator.isRegistered<NavigationService>()) {
          locator.unregister<NavigationService>();
        }
        locator.registerSingleton<NavigationService>(MockNavigationService());
        User user = MockUser();
        String password = "11232342";
        String displayName = "Bilal";
        String email = "bilal@gmail.com";
        String uid = "12345678";
        when(user.displayName).thenReturn(displayName);
        when(user.email).thenReturn(email);
        when(user.uid).thenReturn(uid);
        UserCredential userCredential = MockUserCredential();
        when(userCredential.user).thenReturn(user);
        FirebaseAuth firebaseAuth = MockFirebaseAuth();
        when(firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenAnswer((_) async => userCredential);
        FirebaseAuthenticationService firebaseAuthenticationService =
            FirebaseAuthenticationService(
          auth: firebaseAuth,
        );
        expect(
            (await firebaseAuthenticationService.loginUser(
                    email: email, password: password))
                ?.email,
            email);
      });

      test(
          "Should return the uid of the user logged in with if login was successful",
          () async {
        WidgetsFlutterBinding.ensureInitialized();
        // await LocalStorageServices.init();
        if (locator.isRegistered<NavigationService>()) {
          locator.unregister<NavigationService>();
        }
        locator.registerSingleton<NavigationService>(MockNavigationService());
        User user = MockUser();
        String password = "11232342";
        String displayName = "Bilal";
        String email = "bilal@gmail.com";
        String uid = "12345678";
        when(user.displayName).thenReturn(displayName);
        when(user.email).thenReturn(email);
        when(user.uid).thenReturn(uid);
        UserCredential userCredential = MockUserCredential();
        when(userCredential.user).thenReturn(user);
        FirebaseAuth firebaseAuth = MockFirebaseAuth();
        when(firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenAnswer((_) async => userCredential);
        FirebaseAuthenticationService firebaseAuthenticationService =
            FirebaseAuthenticationService(
          auth: firebaseAuth,
        );
        expect(
            (await firebaseAuthenticationService.loginUser(
                    email: email, password: password))
                ?.id,
            uid);
      });

      test(
          "Should return the display name the user logged in with if login was successful",
          () async {
        WidgetsFlutterBinding.ensureInitialized();
        // await LocalStorageServices.init();
        if (locator.isRegistered<NavigationService>()) {
          locator.unregister<NavigationService>();
        }
        locator.registerSingleton<NavigationService>(MockNavigationService());
        User user = MockUser();
        String password = "11232342";
        String displayName = "Bilal";
        String email = "bilal@gmail.com";
        String uid = "12345678";
        when(user.displayName).thenReturn(displayName);
        when(user.email).thenReturn(email);
        when(user.uid).thenReturn(uid);
        UserCredential userCredential = MockUserCredential();
        when(userCredential.user).thenReturn(user);
        FirebaseAuth firebaseAuth = MockFirebaseAuth();
        when(firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .thenAnswer((_) async => userCredential);
        FirebaseAuthenticationService firebaseAuthenticationService =
            FirebaseAuthenticationService(
          auth: firebaseAuth,
        );
        expect(
            (await firebaseAuthenticationService.loginUser(
                    email: email, password: password))
                ?.name,
            displayName);
      });
    });
  });
}
