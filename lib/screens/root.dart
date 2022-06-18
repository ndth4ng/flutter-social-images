import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:imagesio/screens/auth/login.dart';
import 'package:imagesio/screens/auth/verify_email.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<User?>(context);

    return (currentUser != null) ? const VerifyEmailPage() : const LoginPage();
  }
}
