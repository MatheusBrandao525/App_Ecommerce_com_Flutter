import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/firebase_erros.dart';
import 'package:lojavirtual/models/user.dart' as u;
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;

  Future<void> sigIn(
      {required u.User user,
      required Function onFail,
      required Function onSuccess}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    setLoading(true);
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: user.email, password: user.senha);

      await Future.delayed(Duration(seconds: 4));

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  void setLoading(bool value) {
    loading = value;
  }
}
