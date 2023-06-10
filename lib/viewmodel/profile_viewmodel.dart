import 'package:flutter/widgets.dart';

import '../model/user_model.dart';
import '../services/auth_service.dart';
import '../services/data_service.dart';

class ProfileViewModel extends ChangeNotifier {

  UserModel userModel = UserModel(id: "",email: "",password: "",name: "");
  bool isLoading = false;

  void getUser() async {
    isLoading = true;
    notifyListeners();
    String uid = AuthService.currentUserId();
    await DataService.getUser(uid).then((value) {
        userModel = value!;
        isLoading = false;
        notifyListeners();
    });
  }

}