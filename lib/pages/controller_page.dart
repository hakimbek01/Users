import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task2/pages/create_page.dart';
import 'package:task2/pages/profile_page.dart';
import 'package:task2/pages/search_page.dart';
import 'package:task2/pages/home_page.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {

  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        children: [
          HomePage(),
          SearchPage(),
          CreatePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        selectedLabelStyle: TextStyle(color: Colors.grey),
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedFontSize: 0,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: "Search"
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add),
              label: "Create"
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: "Profile"
          ),
        ],
      ),
    );
  }

  Widget a() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white.withOpacity(.7),
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: "Search"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add),label: "Create"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),label: "Profile"),
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
          case 3:
            return const ProfilePage();
        }
        return const SizedBox();
      },
    );
  }


}
