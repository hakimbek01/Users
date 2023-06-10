import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  bool isLoading = false;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(width: .7,color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Center(
                        child: TextField(
                          controller: controller,
                          onChanged: (value) {
                            searched(value.trim());
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: found.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Text(found[index]),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
        isLoading?
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CupertinoActivityIndicator(),
          ),
        ):
        SizedBox()
      ],
    );
  }

  List<Post> items = [];
  List found = [];
  TextEditingController controller = TextEditingController();

  Future<void> getUser() async {
    setState(() {
      isLoading = true;
    });
    String? rezult = await Network.GET(Network.API_LIST, {});
    setState(() {
      items = Network.parsePostList(rezult!);
      isLoading = false;
    });
  }

  void searched(String value) {
    setState(() {
      found.clear();
    });
    if (value.isEmpty) {
      setState(() {
        found.clear();
      });
      return;
    }
    for (var a in items) {
      if (a.name!.toLowerCase().contains(value.toLowerCase())) {
        setState(() {
          found.add(a.name);
        });
      }
    }
  }

}
