import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/pages/signup_page.dart';
import 'package:task2/viewmodel/signin_viewmodel.dart';
import '../services/auth_service.dart';
import 'controller_page.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


  SignInViewModel signInViewModel = SignInViewModel();


  @override
  void initState() {
    signInViewModel.flipController=FlipCardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return ChangeNotifierProvider(
      create: (context) => signInViewModel,
      child: Consumer<SignInViewModel>(
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
                          height: MediaQuery.of(context).size.height-50,
                          child: Column(
                            children: [
                              FlipCard(
                                controller: signInViewModel.flipController,
                                flipOnTouch: false,
                                front: Image(
                                  height: MediaQuery.of(context).size.width-130,
                                  image: const AssetImage("assets/images/signin.png"),
                                ),
                                back: Image(
                                  height: MediaQuery.of(context).size.width-200,
                                  image: const AssetImage("assets/images/ok.png"),
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
                                  controller: signInViewModel.email,
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
                                  controller: signInViewModel.password,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.7))
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              MaterialButton(
                                height: 45,
                                minWidth: double.infinity,
                                onPressed: (){
                                  signInViewModel.doSignIn(context);
                                },
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10),side: const BorderSide(color: Colors.blue,width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("Sign In",style: TextStyle(fontSize: 18,),),
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                                },
                                child: const Text("Sign Up",style: TextStyle(color: Colors.black,fontSize: 17),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              signInViewModel.isLoading?
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
