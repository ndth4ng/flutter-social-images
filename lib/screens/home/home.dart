import 'package:flutter/material.dart';
import 'package:imagesio/services/auth.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('This is home page. Your email is verified!'),
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
    );
  }
}
