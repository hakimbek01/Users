import 'dart:async';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/controller_page.dart';
import '../services/auth_service.dart';

class SignInViewModel extends ChangeNotifier {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  Timer? timer;
  FlipCardController? flipController;
  bool isLoading=false;

  void doSignIn(context) async {
    String emailStr=email.text.trim();
    String passwordStr=password.text.trim();

    if (emailStr.isEmpty || passwordStr.isEmpty ) return;

    try {
      isLoading=true;
      notifyListeners();
      await AuthService.signIn(emailStr, passwordStr).then((value) => {
        if (value!=null) {
          isLoading=false,
          notifyListeners(),
          flipController!.toggleCard(),
          timer=Timer.periodic(const Duration(milliseconds: 900), (timer) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ControllerPage(),));
            timer.cancel();
          }),
        }
      });
    } catch (e){
      isLoading=false;
      notifyListeners();
    } finally {
      isLoading=false;
      notifyListeners();
    }
  }

}