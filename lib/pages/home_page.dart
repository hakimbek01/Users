import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/pages/editing_page.dart';
import 'package:task2/services/http_service.dart';
import 'package:task2/viewmodel/home_viewmodel.dart';

import '../model/post_model.dart';
import '../view/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel homeViewModel = HomeViewModel();


  @override
  void initState() {
    homeViewModel.getUser(true);
    super.initState();
  }

  @override
  void dispose() {
    print("paka");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
      child: Consumer<HomeViewModel> (
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text("Users",style: TextStyle(fontSize: 22,color: Colors.blue),),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        await Network.POST(Network.API_CREATE, {});
                      },
                      icon: Icon(CupertinoIcons.add,color: Colors.blue,),
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                body: RefreshIndicator(
                  onRefresh: () async {
                    await homeViewModel.getUser(false);
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
                                return itemOfBaner(index,homeViewModel.images[index]);
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
                                    value: homeViewModel.sliderIndex,
                                    onChanged: (value) {
                                      setState(() {
                                        homeViewModel.sliderIndex = value;
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
                                    Text("Preparing",style: TextStyle(fontWeight: FontWeight.bold,color: homeViewModel.sliderIndex>=0?Colors.black:Colors.grey),),
                                    Text("On the way",style: TextStyle(fontWeight: FontWeight.bold,color: homeViewModel.sliderIndex>=1?Colors.black:Colors.grey),),
                                    Text("Delivered",style: TextStyle(fontWeight: FontWeight.bold,color: homeViewModel.sliderIndex>=2?Colors.black:Colors.grey),),
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
                              itemCount: homeViewModel.buttonNames.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      homeViewModel.buttonIndex = index;
                                    });
                                  },
                                  child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(homeViewModel.buttonNames[index],style: TextStyle(fontWeight: FontWeight.bold,color: homeViewModel.buttonIndex==index?Colors.blue:Colors.grey),)
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10,),
                          Column(
                            children: List.generate(homeViewModel.users.length, (index) {
                              return itemOfUser(homeViewModel.users[index], index, context, homeViewModel);
                            })
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              homeViewModel.isLoading?
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ):
              SizedBox()
            ],
          );
        },
      ),
    );
  }





}
