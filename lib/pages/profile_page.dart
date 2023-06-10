import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/model/user_model.dart';
import 'package:task2/pages/signin_page.dart';
import 'package:task2/services/auth_service.dart';
import 'package:task2/services/data_service.dart';
import 'package:task2/viewmodel/profile_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ProfileViewModel profileViewModel = ProfileViewModel();

  @override
  void initState() {
    profileViewModel.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => profileViewModel,
      child: Consumer<ProfileViewModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                  title: Text("Profile",style: TextStyle(color: Colors.blue),),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        await AuthService.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage(),));
                      },
                      icon: Icon(Icons.logout),
                    )
                  ],
                ),
                body: Center(
                  child: Column(
                    children: [
                      Text(profileViewModel.userModel.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                      Text(profileViewModel.userModel.id!,style: TextStyle(color: Colors.grey,fontSize: 17),),
                      Text(profileViewModel.userModel.email!,style: TextStyle(color: Colors.grey,fontSize: 17),),
                      Text(profileViewModel.userModel.password!,style: TextStyle(color: Colors.grey,fontSize: 17),),
                    ],
                  ),
                ),
              ),
              profileViewModel.isLoading?
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
