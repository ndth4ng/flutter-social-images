import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagesio/screens/home_page.dart';
import 'package:imagesio/screens/notification_page.dart';
import 'package:imagesio/screens/profile_page.dart';
import 'package:imagesio/screens/search_page.dart';
import 'package:imagesio/widgets/tabbar_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';

class HomeLayoutPage extends StatefulWidget {
  static const routeName = '/home';
  const HomeLayoutPage({Key? key}) : super(key: key);

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> {
  int _currentIndex = 0;

  final pages = <Widget>[
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Future<File> saveImagePermanently(String imagePath) async {
      final directory = await getApplicationDocumentsDirectory();
      final name = basename(imagePath);
      final image = File('${directory.path}/$name');

      image.writeAsBytes(File(imagePath).readAsBytesSync());

      return File(imagePath).copy(image.path);
      // return image;
    }

    Future getImage(ImageSource source) async {
      try {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: source);

        if (image == null) return;

        // final imageTemporary = File(image.path);

        final imagePermanent = await saveImagePermanently(image.path);

        // print(imageTemporary);

        Navigator.pushNamed(context, 'add-post', arguments: {
          'image': imagePermanent,
        });
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: TabbarWidget(
        index: _currentIndex,
        onChangedTab: onChangedTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blue,
        icon: Icons.add,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.image),
            label: "Gallery",
            onTap: () => getImage(ImageSource.gallery),
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.camera),
            label: "Camera",
            onTap: () => getImage(ImageSource.camera),
          ),
        ],
        tooltip: 'Add',
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
