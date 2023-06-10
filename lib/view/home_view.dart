import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task2/viewmodel/home_viewmodel.dart';

import '../model/post_model.dart';
import '../pages/editing_page.dart';


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

Widget itemOfUser(Post post,int index,context,HomeViewModel homeViewModel){
  return GestureDetector(
    onTap: () async {
      await Navigator.push(context, CupertinoPageRoute(builder: (context) => EditingPage(post: post),));
    },
    child: Container(
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
                        homeViewModel.decrement(index);
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
                          child: Text(homeViewModel.countIndex[index].toString(),style: TextStyle(color: Colors.white),)
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        homeViewModel.increment(index);
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
                        homeViewModel.delUser(post);
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
    ),
  );
}