import 'package:flutter/material.dart';
import 'package:task2/view/home_view.dart';
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
      isLoading = false;
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
    getUser(false);
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
                          checkButton(value1, "Red pepper", ""),
                          checkButton(value2, "Olive", ""),
                          checkButton(value3, "Mushroom", ""),
                          SizedBox(height: 15,),
                          Text("Extra Ingridients",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(height: 15,),
                          checkButton(value4, "Mozarellas cheese", "+1"),
                          checkButton(value5, "Sousage", "+2"),
                          checkButton(value6, "Corn", "+1"),
                          checkButton(value7, "Bacon", "+3"),
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
                                child: InkWell(
                                  onTap: () {
                                    increment(index);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(7),bottomRight: Radius.circular(7)),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Colors.lightBlueAccent.shade100,
                                          Colors.lightBlueAccent
                                        ]
                                      )
                                    ),
                                    child: Center(child: Text("Add to Cart",style: TextStyle(color: Colors.white,fontSize: 17),)),
                                  ),
                                ),
                              ),
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