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
import 'package:imagesio/services/util.dart';
import 'package:imagesio/widgets/tabbar_widget.dart';

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
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;

    handleAdd(ImageSource source) async {
      File? image = await Util().getImage(source);

      if (image != null) {
        Navigator.pushNamed(context, 'add-post', arguments: {
          'image': image,
        });
      }
    }

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: TabbarWidget(
        index: _currentIndex,
        onChangedTab: onChangedTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !showFab,
        child: SpeedDial(
          backgroundColor: Colors.blue,
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(
              child: const Icon(FontAwesomeIcons.image),
              label: "Gallery",
              onTap: () => handleAdd(ImageSource.gallery),
            ),
            SpeedDialChild(
              child: const Icon(FontAwesomeIcons.camera),
              label: "Camera",
              onTap: () => handleAdd(ImageSource.camera),
            ),
          ],
          tooltip: 'Add',
        ),
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
