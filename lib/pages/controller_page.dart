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
        physics: NeverScrollableScrollPhysics(),
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
            pageController.animateToPage(value, duration: Duration(milliseconds: 150), curve: Curves.easeIn);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        currentIndex: currentIndex,
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
