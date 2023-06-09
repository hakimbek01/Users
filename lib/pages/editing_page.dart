import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task2/services/http_service.dart';

import '../model/post_model.dart';
import '../services/utils.dart';

class EditingPage extends StatefulWidget {
  final Post? post;
  const EditingPage({Key? key, this.post}) : super(key: key);

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {

  Post post = Post();
  TextEditingController controllerName = TextEditingController();

  @override
  void initState() {
    setState(() {
      post = widget.post!;
      controllerName.text=post.name!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
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
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: post.avatar!,
              )
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
                      editUser();
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
    );
  }

  void editUser() async {
    post.name = controllerName.text;
    await Network.PUT(Network.API_UPDATE, post.toJson());
    Navigator.pop(context);
    Utils.fToast("Yangilandi");
  }
}
