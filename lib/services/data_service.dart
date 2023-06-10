import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task2/model/user_model.dart';

class DataService {
  static final _firebase = FirebaseFirestore.instance;
  static String users = "users";

  static Future<void> addUser(UserModel userModel) async {
    var docs = _firebase.collection(users).doc();
    userModel.id = docs.id;
    await docs.set(userModel.toJson());
  }

}