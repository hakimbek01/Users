import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task2/model/user_model.dart';

class DataService {
  static final _firebase = FirebaseFirestore.instance;
  static String users = "users";

  static Future<void> addUser(UserModel userModel) async {
    await _firebase.collection(users).doc(userModel.id).set(userModel.toJson());
  }

  static Future<UserModel?> getUser(String uid) async {
     var docs = await _firebase.collection(users).doc(uid).get();
     return UserModel.fromJson(docs.data()!);
  }

}