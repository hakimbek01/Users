import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task2/services/http_service.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double sliderIndex = 0;
  List buttonNames = ["All","Pizzas","Burgers","Beverages","Desert"];
  List images = ['assets/images/img.png','assets/images/img_1.png','assets/images/img_2.png'];
  PageController pageController = PageController();
  int buttonIndex = 0;
  bool isLoading = false;
  List<Post> users = [];

  @override
  void initState() {
    getUser(true);
    super.initState();
  }

  @override
  void dispose() {
    print("paka");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text("Users",style: TextStyle(fontSize: 22,color: Colors.blue),),
          ),
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () async {
              await getUser(false);
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width/2,
                      child: Swiper(
                        itemBuilder: (BuildContext context,int index){
                          return itemOfBaner(index,images[index]);
                        },
                        itemCount: 2,
                        viewportFraction: 0.8,
                        scale: 0.9,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text("Current Order",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    const SizedBox(height: 10,),
                    //current orders
                    Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 3,
                                blurRadius: 7
                            )
                          ]
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Slider(
                              value: sliderIndex,
                              onChanged: (value) {
                                setState(() {
                                  sliderIndex = value;
                                });
                              },
                              activeColor: Colors.blue,
                              min: 0,
                              max: 3,
                              divisions: 2,
                              inactiveColor: Colors.grey.shade100,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Preparing",style: TextStyle(fontWeight: FontWeight.bold,color: sliderIndex>=0?Colors.black:Colors.grey),),
                              Text("On the way",style: TextStyle(fontWeight: FontWeight.bold,color: sliderIndex>=1?Colors.black:Colors.grey),),
                              Text("Delivered",style: TextStyle(fontWeight: FontWeight.bold,color: sliderIndex>=2?Colors.black:Colors.grey),),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: buttonNames.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                buttonIndex = index;
                              });
                            },
                            child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(buttonNames[index],style: TextStyle(fontWeight: FontWeight.bold,color: buttonIndex==index?Colors.blue:Colors.grey),)
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      children: users.map((e) {
                        return itemOfUser(e,0);
                      }).toList(),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading?
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ):
        SizedBox()
      ],
    );
  }

  Widget itemOfBaner(index,String image) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      clipBehavior: Clip.hardEdge,
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage(image),
      ),
    );
  }

  Widget itemOfUser(Post post,int index){
    return Container(
      width: double.infinity,
      height: 200 ,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 7,
            spreadRadius: 3
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 130,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7)
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: post.avatar!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 70,
                            child: Text(post.name!,maxLines:3,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17,overflow: TextOverflow.ellipsis),)
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(post.id!+"\$",style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16),),
                            SizedBox(
                              height: 20,
                              width: 40,
                              child: Stack(
                                children: [
                                  Center(child: Text(post.count!.toString()+"\$",style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 13),)),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 1,
                                      width: 30,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                          setState(() {
                            index-=1;
                          });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child: Center(
                          child: Icon(CupertinoIcons.minus,color: Colors.blue,)
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.grey),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.blue,
                            Colors.blue.withOpacity(.6),
                          ]
                        )
                      ),
                      child: Center(
                        child: Text(index.toString(),style: TextStyle(color: Colors.white),)
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index+=1;
                        });
                        print(index);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                            border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child: Center(
                            child: Icon(Icons.add,color: Colors.blue,)
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("To'liq ismi",style: TextStyle(color: Colors.grey,fontSize: 12),),
                      Text(post.name!,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(.3),
                    child: IconButton(
                      onPressed: () {
                        delUser(post);
                      },
                      icon: Icon(CupertinoIcons.delete,color: Colors.red,),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getUser(bool a) async {
    if (a) {
      setState(() {
        isLoading = true;
      });

      String? rezult = await Network.GET(Network.API_LIST, {});

      setState(() {
        users = Network.parsePostList(rezult!);
        isLoading = false;
      });
    } else {
      String? rezult = await Network.GET(Network.API_LIST, {});
    }
  }

  void delUser(Post post) async {
    setState(() {
      isLoading = true;
    });
    await Network.DEL(Network.API_DELETE+post.id!, {});
    getUser(true);
  }

}
