import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_manger.dart';
import 'package:lojavirtual/screens/base/base_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Corrigindo o bug da tela vermelha ao iniciar o App 21/07/2022.
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: BaseScreen(),
      ),
    );
  }
}
