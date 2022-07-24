import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/firebase_erros.dart';
import 'package:lojavirtual/models/user.dart';

class UserManager extends ChangeNotifier {
  userManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  late UserModel user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> sigIn(
      {required UserModel user,
      required Function onFail,
      required Function onSuccess}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    loading = true;
    try {
      // ignore: unused_local_variable
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: user.email, password: user.senha);

      if (user.email != null && user.senha != null) {
        User? user = userCredential.user;
      }

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {required UserModel user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: user.email, password: user.senha);

      if (user.email != null && user.senha != null) {
        User? user = userCredential.user;
      }

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _loadCurrentUser() async {
    final UserModel currentUser = auth.currentUser as UserModel;
    user = currentUser;
    if (kDebugMode) {
      print(user.uid);
    }
    notifyListeners();
  }
}
