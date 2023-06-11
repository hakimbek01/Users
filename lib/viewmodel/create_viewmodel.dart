import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../model/post_model.dart';
import '../services/http_service.dart';
import '../services/utils.dart';


class CreateViewModel extends ChangeNotifier{

  ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController controllerName = TextEditingController();
  bool isLoading = false;

  void openGallery() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery,imageQuality: 20);

    image = File(file!.path);
    notifyListeners();
  }

  void addUser() async {
    if (controllerName.text=="" || image==null) {
      Utils.fToast("Ma'lumotlarni to'liq kiriting");
      return;
    }

    isLoading = true;
    notifyListeners();
    Post post = Post(name: controllerName.text,avatar: image!.path,id: '0',count: 0);
    await Network.POST(Network.API_CREATE, post.toJson());
    isLoading = false;
    controllerName.clear();
    image = null;
    notifyListeners();
    Utils.fToast("Yangi User");
  }
}