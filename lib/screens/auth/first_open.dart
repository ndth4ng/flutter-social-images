import 'package:flutter/material.dart';
import 'package:imagesio/screens/auth/login.dart';
import 'package:imagesio/screens/auth/register.dart';
import 'package:imagesio/widgets/long_button.dart';

class FirstOpen extends StatelessWidget {
  static const routeName = 'first';
  const FirstOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    goToLoginScreen() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }

    goToRegisterScreen() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: const [
                    Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      'imagesio',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 160.0,
              ),
              Center(
                child: Column(
                  children: [
                    LongButton(
                        text: 'Create your account', onPress: goToLoginScreen),
                    const SizedBox(
                      height: 32.0,
                    ),
                    TextButton(
                      onPressed: goToRegisterScreen,
                      child: const Text('Already a member?'),
                      style: TextButton.styleFrom(primary: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
