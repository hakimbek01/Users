import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';
import '../services/utils.dart';

class EditingViewModel extends ChangeNotifier {

  Post post = Post();
  TextEditingController controllerName = TextEditingController();

  void editUser(context) async {
    post.name = controllerName.text;
    await Network.PUT(Network.API_UPDATE, post.toJson());
    Navigator.pop(context);
    Utils.fToast("Yangilandi");
  }

}