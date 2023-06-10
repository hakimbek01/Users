import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Future<void> delUser(Post post) async {
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

  Future bottomSheet(context) {
    bool? value1 = false;
    bool? value2 = false;
    bool? value3 = false;
    bool? value4 = false;
    bool? value5 = false;
    bool? value6 = false;
    bool? value7 = false;
    bool? value8 = false;
    bool? value9 = false;
    bool? value10 = false;


    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text("Customize Order",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close,size: 32,),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Remove Ingredients",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Red pepper",style: TextStyle(color: Colors.grey),),
                              Checkbox(
                                value: value1,
                                onChanged: (value) {
                                  value1 = value;
                                  notifyListeners();
                                },
                                activeColor: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Olive",style: TextStyle(color: Colors.grey),),
                              Checkbox(
                                value: value2,
                                onChanged: (value) {
                                  value2 = value;
                                  notifyListeners();
                                },
                                activeColor: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mushroom",style: TextStyle(color: Colors.grey),),
                              Checkbox(
                                value: value3,
                                onChanged: (value) {
                                  value3 = value;
                                  notifyListeners();
                                },
                                activeColor: Colors.blue,
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text("Extra Ingridients",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mozzarella cheese",style: TextStyle(color: Colors.grey),),
                              Row(
                                children: [
                                  Text("+1",style: TextStyle(color: Colors.grey),),
                                  SizedBox(width: 5,),
                                  Checkbox(
                                    value: value4,
                                    onChanged: (value) {
                                      value4 = value;
                                      notifyListeners();
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sousage",style: TextStyle(color: Colors.grey),),
                              Row(
                                children: [
                                  Text("+2",style: TextStyle(color: Colors.grey),),
                                  SizedBox(width: 5,),
                                  Checkbox(
                                    value: value5,
                                    onChanged: (value) {
                                      value5 = value;
                                      notifyListeners();
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Corn",style: TextStyle(color: Colors.grey),),
                              Row(
                                children: [
                                  Text("+1",style: TextStyle(color: Colors.grey),),
                                  SizedBox(width: 5,),
                                  Checkbox(
                                    value: value6,
                                    onChanged: (value) {
                                      value6 = value;
                                      notifyListeners();
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bacon",style: TextStyle(color: Colors.grey),),
                              Row(
                                children: [
                                  Text("+3",style: TextStyle(color: Colors.grey),),
                                  SizedBox(width: 5,),
                                  Checkbox(
                                    value: value7,
                                    onChanged: (value) {
                                      value7 = value;
                                      notifyListeners();
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text("Beverage",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Nothing",style: TextStyle(color: Colors.grey),),
                              Radio(
                                value: true,
                                groupValue: value8,
                                onChanged: (value) {
                                  value8 = value;
                                  notifyListeners();
                                },
                                activeColor: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Coke",style: TextStyle(color: Colors.grey),),
                              Row(
                                children: [
                                  Text("+3",style: TextStyle(color: Colors.grey),),
                                  SizedBox(width: 5,),
                                  Radio(
                                    value: true,
                                    groupValue: value9,
                                    onChanged: (value) {
                                      value9 = value;
                                      notifyListeners();
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ayran",style: TextStyle(color: Colors.grey),),
                              Row(
                                children: [
                                  Text("+2",style: TextStyle(color: Colors.grey),),
                                  SizedBox(width: 5,),
                                  Radio(
                                    value: true,
                                    groupValue: value10,
                                    onChanged: (value) {
                                      value10 = value;
                                      notifyListeners();
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

}