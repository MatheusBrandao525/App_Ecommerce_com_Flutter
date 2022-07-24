import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_manger.dart';
import 'package:lojavirtual/screens/base/base_screen.dart';
import 'package:lojavirtual/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Corrigindo o bug da tela vermelha ao iniciar o App 21/07/2022.
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja do Matheus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 8, 108, 122),
            scaffoldBackgroundColor: const Color.fromARGB(255, 8, 108, 122),
            appBarTheme: const AppBarTheme(elevation: 0)),
        initialRoute: '/base',
        onGenerateRoute: (Settings) {
          switch (Settings.name) {
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignupScreen());

            case '/base':
              return MaterialPageRoute(builder: (_) => const BaseScreen());

            default:
              return MaterialPageRoute(builder: (_) => const BaseScreen());
          }
        },
      ),
    );
  }
}
