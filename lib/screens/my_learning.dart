import 'package:flutter/material.dart';
import 'package:microsoft/utils/enums.dart';
import 'package:microsoft/utils/navigator.dart';

class MyLearning extends StatefulWidget {
  static String routeName = 'my_learning';
  const MyLearning({super.key});

  @override
  State<MyLearning> createState() => _MyLearningState();
}

class _MyLearningState extends State<MyLearning> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: NavigationContainer(chose: MenuState.myLearning),
    );
  }
}
