import 'package:flutter/material.dart';
import 'package:task2/pages/controller_page.dart';
import 'package:task2/pages/signin_page.dart';

import '../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void isSignUser() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    bool isLogged = AuthService.currentUser();
    if (!isLogged || isLogged == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ControllerPage(),));
    }
  }

  @override
  void initState() {
    isSignUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
