import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var authenticated = FirebaseAuth.instance.currentUser != null;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Home'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pushNamed(context, '/'),
                enabled: authenticated,
              ),
              ListTile(
                title: const Text('About'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pushNamed(context, '/about'),
              ),
              ListTile(
                title: const Text('Sign In'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.login_rounded,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pushNamed(context, '/sign-in'),
                enabled: !authenticated,
              ),
              ListTile(
                title: const Text('Profile'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pushNamed(context, '/profile'),
                enabled: authenticated,
              ),
              ListTile(
                title: const Text('Sign Out'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/sign-in');
                },
                enabled: authenticated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
