import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  static const routeName = 'add-post';
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final image = arg['image'];

    print(image);

    return Scaffold(
      appBar: AppBar(),
      body: Image.file(image),
    );
  }
}
