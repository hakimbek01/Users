import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task2/model/post_model.dart';
import 'package:task2/services/http_service.dart';
import 'package:task2/view/home_view.dart';
import 'package:task2/viewmodel/create_viewmodel.dart';

import '../services/utils.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}



class _CreatePageState extends State<CreatePage> {

  CreateViewModel createViewModel = CreateViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => createViewModel,
      child: Consumer<CreateViewModel>(
        builder: (context, value, child) {
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
                        child: createViewModel.image==null?
                        GestureDetector(
                          onTap: () {
                            createViewModel.openGallery();
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
                              image: FileImage(createViewModel.image!),
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
                                        createViewModel.image = null;
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
                                controller: createViewModel.controllerName,
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
                                createViewModel.addUser();
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
              createViewModel.isLoading?
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ):
              SizedBox()
            ],
          );
        },
      ),
    );
  }



  @override
  void dispose() {
    createViewModel.image = null;
    createViewModel.controllerName.dispose();
    super.dispose();
  }
}
