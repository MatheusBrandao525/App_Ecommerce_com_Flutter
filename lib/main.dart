import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_manger.dart';
import 'package:lojavirtual/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

void main() {
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
