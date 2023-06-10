import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/pages/editing_page.dart';
import 'package:task2/viewmodel/search_viewmodel.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  SearchViewModel searchViewModel = SearchViewModel();


  @override
  void initState() {
    searchViewModel.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => searchViewModel,
      child: Consumer<SearchViewModel>(
        builder: (context, value, child) {
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
                                controller:  searchViewModel.controller,
                                onChanged: (value) {
                                  searchViewModel.searched(value.trim());
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Expanded(
                            child: ListView.builder(
                              itemCount:  searchViewModel.found.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => EditingPage(post: searchViewModel.found[index]),));
                                  },
                                  child: SizedBox(
                                      height: 30,
                                      child: Text(searchViewModel.found[index].name!)
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              searchViewModel.isLoading?
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
