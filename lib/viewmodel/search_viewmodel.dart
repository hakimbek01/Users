import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';

class SearchViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Post> items = [];
  List<Post> found = [];
  TextEditingController controller = TextEditingController();

  Future<void> getUser() async {
    isLoading = true;
    notifyListeners();
    String? rezult = await Network.GET(Network.API_LIST, {});
    items = Network.parsePostList(rezult!);
    isLoading = false;
    notifyListeners();
  }

  void searched(String value) {
    found.clear();
    notifyListeners();
    if (value.isEmpty) {
      found.clear();
      notifyListeners();
      return;
    }
    for (var a in items) {
      if (a.name!.toLowerCase().contains(value.toLowerCase())) {
        found.add(a);
        notifyListeners();
      }
    }
  }
}