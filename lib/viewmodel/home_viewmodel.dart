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
  List<int> countIndex = [];
  int count = 0;

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

    for(var a in users) {
      countIndex.add(0);
    }
  }

  void delUser(Post post) async {
    isLoading = true;
    notifyListeners();
    await Network.DEL(Network.API_DELETE+post.id!, {});
    getUser(true);
  }


  void increment(int index) {
    countIndex[index]++;
    notifyListeners();
  }

  void decrement(int index) {

    if (countIndex[index]>0) {
      countIndex[index]--;
    }

    notifyListeners();
  }

}