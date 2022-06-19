import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imagesio/firebase_options.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/providers/auth_provider.dart';
import 'package:imagesio/screens/auth/first_open.dart';
import 'package:imagesio/screens/auth/login.dart';
import 'package:imagesio/screens/auth/register.dart';
import 'package:imagesio/screens/auth/verify_email.dart';
import 'package:imagesio/screens/home/home_layout.dart';
import 'package:imagesio/screens/post/add_post.dart';
import 'package:imagesio/screens/post/comment_page.dart';
import 'package:imagesio/screens/post/post_page.dart';
import 'package:imagesio/screens/root.dart';
import 'package:imagesio/services/auth.dart';
import 'package:imagesio/services/post.dart';
import 'package:provider/provider.dart';

// import 'package:imagesio/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          create: (context) => AuthService().firebaseUser,
          initialData: null,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: const Color(0xFFFEFEFE),
            fontFamily: 'Poppins',
          ),
          // home: StreamBuilder<User?>(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return const VerifyEmailPage();
          //     } else {
          //       return const LoginPage();
          //     }
          //   },
          // ),
          home: const Root(),
          routes: {
            FirstOpen.routeName: (context) => const FirstOpen(),
            HomeLayoutPage.routeName: (context) => const HomeLayoutPage(),
            LoginPage.routeName: (context) => const LoginPage(),
            RegisterPage.routeName: (context) => const RegisterPage(),
            PostPage.routeName: (context) => const PostPage(),
            AddPostPage.routeName: (context) => const AddPostPage(),
            CommentPage.routeName: (context) => const CommentPage(),
          }),
    );
  }
}
