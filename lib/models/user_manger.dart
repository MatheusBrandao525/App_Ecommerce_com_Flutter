import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user.dart' as u;
import 'package:flutter/services.dart';

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sigIn(u.User user) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: user.email, password: user.senha);

      print(userCredential.user!.uid);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
