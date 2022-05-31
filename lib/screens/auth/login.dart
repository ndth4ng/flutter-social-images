import 'package:flutter/material.dart';
import 'package:imagesio/services/auth.dart';
import 'package:imagesio/shared/constants.dart';
import 'package:imagesio/widgets/custom_divider.dart';
import 'package:imagesio/widgets/long_button.dart';
import 'package:imagesio/widgets/prefix_icon.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  String email = '';
  String password = '';

  handleLogin() {
    if (_formKey.currentState!.validate()) {
      AuthService()
          .signIn(email: email.trim(), password: password.trim())
          .then((result) {
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(32.0, 30.0, 32.0, 12.0),
            children: [
              Row(
                children: const [
                  Image(
                    image: AssetImage('assets/logo.png'),
                    height: 70.0,
                  ),
                ],
              ),
              const Text(
                'Welcome to',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w100),
              ),
              const Text(
                'Imagesio',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Enter your email";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: "Email",
                        hintText: "Enter your email",
                        prefixIcon: const CustomPrefixIcon(icon: Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: _obscureText,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: "Password",
                        hintText: "Enter your password",
                        prefixIcon: const CustomPrefixIcon(icon: Icons.key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    LongButton(text: 'Login', onPress: handleLogin)
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const CustomDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: const Image(
                      image: AssetImage('assets/facebook-logo.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: const Image(
                      image: AssetImage('assets/google-logo.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    child: const Image(
                      image: AssetImage('assets/apple-logo.png'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do not have an account?"),
                  TextButton(
                    onPressed: () {
                      // widget.toggleView();
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
