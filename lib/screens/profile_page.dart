import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<User?>(context);

    // print(currentUser?.uid);

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Author? author =
              Author.fromJson(snapshot.data.data() as Map<String, dynamic>);

          print(author.username);
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
                        print(author.username);
                      },
                      child: const Text('Information'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
