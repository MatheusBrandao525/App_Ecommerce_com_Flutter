import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_dawer/custom_drawer.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),
          Container(color: Colors.red),
          Container(color: Colors.amber),
          Container(
            color: Colors.green,
          ),
        ]);
  }
}
