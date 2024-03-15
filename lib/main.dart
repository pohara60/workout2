import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:workout2/firebase_options.dart';

import 'src/about.dart';
import 'src/home.dart';
import 'src/scaffold_widget.dart';
import 'src/sign_in_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),

      // Issues:
      // 1. After Register, should go to Sign In
      // 2. Profile email verification keeps saying waiting, cannot exit

      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
      routes: {
        '/': (context) {
          return const MyHomePage(title: 'Home');
        },
        '/about': (context) {
          return const ScaffoldWidget("About", About());
        },
        '/sign-in': (context) {
          return SignInWidget();
        },
        '/verify-email': (context) {
          return ScaffoldWidget(
              "Email Verification",
              EmailVerificationScreen(
                headerBuilder: headerIcon(Icons.verified),
                sideBuilder: sideIcon(Icons.verified),
                // actionCodeSettings: actionCodeSettings,
                actions: [
                  EmailVerifiedAction(() {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }),
                  AuthCancelledAction((context) {
                    FirebaseUIAuth.signOut(context: context);
                    Navigator.pushReplacementNamed(context, '/');
                  }),
                ],
              ));
        },
        '/forgot-password': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return ScaffoldWidget(
              "Forgot Password",
              ForgotPasswordScreen(
                email: arguments?['email'],
                headerMaxExtent: 200,
                headerBuilder: headerIcon(Icons.lock),
                sideBuilder: sideIcon(Icons.lock),
              ));
        },
        '/profile': (context) {
          if (FirebaseAuth.instance.currentUser == null) {
            return SignInWidget();
          }
          return ScaffoldWidget(
              "Profile",
              ProfileScreen(
                actions: [
                  SignedOutAction((context) {
                    Navigator.pushReplacementNamed(context, '/');
                  }),
                ],
                // actionCodeSettings: actionCodeSettings,
                showUnlinkConfirmationDialog: true,
                showDeleteConfirmationDialog: true,
              ));
        },
      },
    );
  }
}

HeaderBuilder headerImage(String assetName) {
  return (context, constraints, _) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(assetName),
    );
  };
}

HeaderBuilder headerIcon(IconData icon) {
  return (context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20).copyWith(top: 40),
      child: Icon(
        icon,
        color: Colors.blue,
        size: constraints.maxWidth / 4 * (1 - shrinkOffset),
      ),
    );
  };
}

SideBuilder sideImage(String assetName) {
  return (context, constraints) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(constraints.maxWidth / 4),
        child: Image.asset(assetName),
      ),
    );
  };
}

SideBuilder sideIcon(IconData icon) {
  return (context, constraints) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Icon(
        icon,
        color: Colors.blue,
        size: constraints.maxWidth / 3,
      ),
    );
  };
}
