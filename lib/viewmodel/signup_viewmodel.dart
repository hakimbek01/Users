import 'dart:async';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/user_model.dart';
import '../pages/controller_page.dart';
import '../services/auth_service.dart';
import '../services/data_service.dart';

class SignUpViewModel extends ChangeNotifier {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  TextEditingController name=TextEditingController();
  Timer? timer;
  FlipCardController? flipController;
  bool isLoading=false;


  void doSignUp(context) async {
    String emailStr=email.text.trim();
    String passwordStr=password.text.trim();
    String nameStr=name.text.trim();
    String confirmPasswordStr=confirmPassword.text.trim();

    if (emailStr.isEmpty || passwordStr.isEmpty || nameStr.isEmpty || passwordStr != confirmPasswordStr) return;
    if (confirmPassword!=password) return;

    try {
      await AuthService.signUp(emailStr, passwordStr).then((value) async => {
        if (value!=null) {
          flipController!.toggleCard(),
          timer=Timer.periodic(const Duration(milliseconds: 900), (timer) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ControllerPage(),));
            timer.cancel();
          }),
          await addUserFirestore(value.uid),
          isLoading=false,
          notifyListeners()
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


  Future<void> addUserFirestore(String uid) async {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty || confirmPassword.text.isEmpty) return;
    UserModel userModel = UserModel(name: name.text,password: password.text,email: email.text,id: uid);
    await DataService.addUser(userModel);
    isLoading=true;
    notifyListeners();
  }
}