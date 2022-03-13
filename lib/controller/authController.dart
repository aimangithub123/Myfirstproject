import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;
  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> SignUp({String? email, String? password}) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error in creating account", e.message.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> SignIn({String? email, String? password}) async {

    try {
      await _auth.signInWithEmailAndPassword(password: password!, email: email!);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error in login to account", e.message.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> signOut() async {
    print("Logout");
    await _auth.signOut();
  }

  }

