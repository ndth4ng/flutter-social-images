import 'package:flutter/material.dart';
import 'package:imagesio/services/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('This is profile page. Your email is verified!'),
              ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                },
                child: const Text('Sign out'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(AuthService().user);
                },
                child: const Text('Information'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
