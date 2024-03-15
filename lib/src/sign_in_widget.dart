import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'scaffold_widget.dart';

class SignInWidget extends StatelessWidget {
  SignInWidget({
    super.key,
  });

  final providers = [EmailAuthProvider()];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        "Sign In",
        SignInScreen(
          providers: providers,
          actions: [
            ForgotPasswordAction((context, email) {
              Navigator.pushNamed(
                context,
                '/forgot-password',
                arguments: {'email': email},
              );
            }),
            AuthStateChangeAction((context, state) {
              final user = switch (state) {
                SignedIn(user: final user) => user,
                CredentialLinked(user: final user) => user,
                UserCreated(credential: final cred) => cred.user,
                _ => null,
              };

              switch (user) {
                case User(emailVerified: true):
                  Navigator.pushReplacementNamed(context, '/');
                case User(emailVerified: false, email: final String _):
                  Navigator.pushNamed(context, '/verify-email');
              }
            }),
          ],
        ));
  }
}
