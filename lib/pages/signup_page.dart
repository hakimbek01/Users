import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/model/user_model.dart';
import 'package:task2/pages/controller_page.dart';
import 'package:task2/pages/signin_page.dart';
import 'package:task2/services/data_service.dart';
import 'package:task2/viewmodel/signup_viewmodel.dart';
import '../services/auth_service.dart';
import 'home_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  SignUpViewModel signUpViewModel = SignUpViewModel();


  @override
  void initState() {
    signUpViewModel.flipController=FlipCardController();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => signUpViewModel,
      child: Consumer<SignUpViewModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height-30,
                          child: Column(
                            children: [
                              FlipCard(
                                controller: signUpViewModel.flipController,
                                flipOnTouch: false,
                                front: Image(
                                  height: MediaQuery.of(context).size.width-130,
                                  image: const AssetImage("assets/images/signup.png"),
                                ),
                                back: Image(
                                  height: MediaQuery.of(context).size.width-200,
                                  image: const AssetImage("assets/images/ok.png"),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              //name
                              Container(
                                height: 45,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(width: .5,color: Colors.blue)
                                ),
                                child: TextField(
                                  controller: signUpViewModel.name,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.7))
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              //email
                              Container(
                                height: 45,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(width: .5,color: Colors.blue)
                                ),
                                child: TextField(
                                  controller: signUpViewModel.email,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.7))
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              //password
                              Container(
                                height: 45,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(width: .5,color: Colors.blue)
                                ),
                                child: TextField(
                                  controller: signUpViewModel.password,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.7))
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              //confirm password
                              Container(
                                height: 45,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(width: .5,color: Colors.blue)
                                ),
                                child: TextField(
                                  controller: signUpViewModel.confirmPassword,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.7))
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              MaterialButton(
                                height: 45,
                                minWidth: double.infinity,
                                onPressed: (){
                                  signUpViewModel.doSignUp(context);
                                },
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10),side: const BorderSide(color: Colors.blue,width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("Sign Up",style: TextStyle(fontSize: 18,),),
                                    const Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Huquqlar himoya qilingan"),
                              const SizedBox(width: 10,),
                              TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
                                },
                                child: const Text("Sign In",style: TextStyle(color: Colors.black,fontSize: 17),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              signUpViewModel.isLoading?
              const Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ):
              const SizedBox()
            ],
          );
        },
      ),
    );
  }


}
