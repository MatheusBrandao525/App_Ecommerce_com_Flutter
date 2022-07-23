import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/firebase_erros.dart';
import 'package:lojavirtual/models/user.dart' as u;
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  userManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  late u.User user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> sigIn(
      {required u.User user,
      required Function onFail,
      required Function onSuccess}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    loading = true;
    try {
      // ignore: unused_local_variable
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: user.email, password: user.senha);

      this.user = userCredential.user as u.User; // bug aqui

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
    final u.User currentUser = auth.currentUser as u.User;
    if (currentUser != null) {
      user = currentUser as u.User;
      print(user.uid);
    }
    notifyListeners();
  }
}
