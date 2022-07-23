import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_dawer/custom_drawer.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            LoginScreen(),
            Scaffold(
              drawer: const CustomDrawer(),
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 8, 108, 122),
                title: const Text('Home2'),
              ),
            ),
            Scaffold(
              drawer: const CustomDrawer(),
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 8, 108, 122),
                title: const Text('Home3'),
              ),
            ),
            Scaffold(
              drawer: const CustomDrawer(),
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 8, 108, 122),
                title: const Text('Home4'),
              ),
            ),
            Container(color: Colors.red),
            Container(color: Colors.amber),
            Container(
              color: Colors.green,
            ),
          ]),
    );
  }
}
