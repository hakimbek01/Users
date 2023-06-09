import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task2/pages/create_page.dart';
import 'package:task2/pages/search_page.dart';
import 'package:task2/pages/home_page.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white.withOpacity(.7),
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: "Search"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add),label: "Create"),
        ],
      ),
      tabBuilder: (context, index) {
        switch(index) {
          case 0:
            return const HomePage();
          case 1:
            return const SearchPage();
          case 2:
            return const CreatePage();
        }
        return const SizedBox();
      },
    );
  }
}
