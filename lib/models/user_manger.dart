import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/firebase_erros.dart';
import 'package:lojavirtual/models/user.dart' as u;
import 'package:flutter/services.dart';

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sigIn(
      {required u.User user,
      required Function onFail,
      required Function onSuccess}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: user.email, password: user.senha);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
  }
}