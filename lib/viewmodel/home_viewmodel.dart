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

  void bottomSheet(context,price,index)  {
    bool? value1 = false;
    bool? value2 = false;
    bool? value3 = false;
    bool? value4 = false;
    bool? value5 = false;
    bool? value6 = false;
    bool? value7 = false;
    List list = [0,1,2];
    int? currentRadio;
    showModalBottomSheet(
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
                                  setState((){
                                    value1 = value;
                                  });
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
                                  setState((){
                                    value2 = value;
                                  });
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
                                  setState((){
                                    value3 = value;
                                  });
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
                                      setState((){
                                        value4 = value;
                                      });
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
                                      setState((){
                                        value5 = value;
                                      });
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
                                      setState((){
                                        value6 = value;
                                      });
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
                                      setState((){
                                        value7 = value;
                                      });
                                    },
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
                                value: list[0],
                                groupValue: currentRadio,
                                onChanged: (value) {
                                  setState((){
                                   currentRadio = value;
                                  });
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
                                    value: list[1],
                                    groupValue: currentRadio,
                                    onChanged: (value) {
                                      setState((){
                                        currentRadio = value;
                                      });
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
                                    value: list[2],
                                    groupValue: currentRadio,
                                    onChanged: (value) {
                                      setState((){
                                        currentRadio = value;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 100,
                                margin: EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(7),bottomLeft: Radius.circular(7)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      spreadRadius: 3,
                                      blurRadius: 8
                                    )
                                  ]
                                ),
                                child: Center(
                                  child: Text(price+"\$",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    increment(index);
                                    Navigator.pop(context);
                                  },
                                  height: 50,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(7),bottomRight: Radius.circular(7))),
                                  color: Colors.lightBlueAccent,
                                  child: Text("Add to Cart",style: TextStyle(color: Colors.white,fontSize: 17),),
                                ),
                              ),
                              SizedBox(width: 5,),
                            ],
                          ),
                          SizedBox(height: 20,),
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