import 'package:firebase_auth/firebase_auth.dart';
import 'package:task2/services/data_service.dart';
import 'package:task2/services/utils.dart';

class AuthService {
  static final _auth=FirebaseAuth.instance;

  static Future<User?> signIn(String email,password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=_auth.currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      Utils.fToast("Xatolik yuz berdi");
    }
  }

  static Future<User?> signUp(String email,password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=_auth.currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      Utils.fToast("Xatolik yuz berdi");
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static bool currentUser() {
    User? user=_auth.currentUser;
    return user!=null;
  }

  static String currentUserId() {
    User? user=_auth.currentUser;
    return user!.uid;
  }
}