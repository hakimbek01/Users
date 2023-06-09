import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';

class HomeViewModel extends ChangeNotifier {
  double sliderIndex = 0;
  List buttonNames = ["All","Pizzas","Burgers","Beverages","Desert"];
  List images = ['assets/images/img.png','assets/images/img_1.png','assets/images/img_2.png'];
  PageController pageController = PageController();
  int buttonIndex = 0;
  bool isLoading = false;
  List<Post> users = [];

  Future<void> getUser(bool a) async {
    if (a) {
      isLoading = true;
      notifyListeners();
      String? rezult = await Network.GET(Network.API_LIST, {});
      users = Network.parsePostList(rezult!);
      isLoading = false;
      notifyListeners();
    } else {
      String? rezult = await Network.GET(Network.API_LIST, {});
      users = Network.parsePostList(rezult!);
      notifyListeners();
    }
  }

  void delUser(Post post) async {
    isLoading = true;
    notifyListeners();
    await Network.DEL(Network.API_DELETE+post.id!, {});
  }
}