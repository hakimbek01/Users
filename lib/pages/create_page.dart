import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task2/model/post_model.dart';
import 'package:task2/services/http_service.dart';

import '../services/utils.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

  ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController controllerName = TextEditingController();
  bool isLoading = false;

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text("Create",style: TextStyle(color: Colors.blue),),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width-100,
                  width: double.infinity,
                  child: image==null?
                  GestureDetector(
                    onTap: () {
                      openGallery();
                    },
                    child: const Image(
                      image: AssetImage('assets/images/img_3.png',),
                      width: 40,
                    ),
                  ):
                  Stack(
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.width-100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: FileImage(image!),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.all(15),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(.3),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  image = null;
                                });
                              },
                              icon: Icon(CupertinoIcons.delete,color: Colors.red,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: controllerName,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.green,
                        onPressed: () {
                          addUser();
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Text("Publish",style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                )
              ],
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

  void openGallery() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery,imageQuality: 20);

    setState(() {
      image = File(file!.path);
    });
  }

  void addUser() async {
    if (controllerName.text=="" || image==null) {
      Utils.fToast("Ma'lumotlarni to'liq kiriting");
      return;
    }


    setState(() {
      isLoading = true;
    });
    Post post = Post(name: controllerName.text,avatar: image!.path,id: '0',count: 0);
    await Network.POST(Network.API_CREATE, post.toJson());
    setState(() {
      isLoading = false;
    });
    Utils.fToast("Yangi User");
  }

  @override
  void dispose() {
    image = null;
    controllerName.dispose();
    super.dispose();
  }
}
