import 'package:flutter/material.dart';
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

  final pages = <Widget>[
    HomePage(),
    SearchPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: TabbarWidget(
        index: _currentIndex,
        onChangedTab: onChangedTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
