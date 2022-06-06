import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagesio/screens/home_page.dart';
import 'package:imagesio/screens/notification_page.dart';
import 'package:imagesio/screens/profile_page.dart';
import 'package:imagesio/screens/search_page.dart';
import 'package:imagesio/services/auth.dart';
import 'package:imagesio/widgets/tabbar_widget.dart';

class HomeLayoutPage extends StatefulWidget {
  static const routeName = '/home';
  const HomeLayoutPage({Key? key}) : super(key: key);

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> {
  int _currentIndex = 0;
  File? image;

  final pages = <Widget>[
    HomePage(),
    SearchPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);

        if (image == null) return;

        final imageTemporary = File(image.path);
        this.image = imageTemporary;
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
