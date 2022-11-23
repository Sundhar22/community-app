import 'package:flutter/material.dart';
import 'package:microsoft/auth_page/login_screen.dart';
import 'package:microsoft/auth_page/register_screen.dart';
import 'package:microsoft/screens/chat_bot.dart';
import 'package:microsoft/screens/community.dart';
import 'package:microsoft/screens/home.dart';
import 'package:microsoft/screens/my_learning.dart';

final Map<String, WidgetBuilder> routeSettings = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  MyLearning.routeName: (context) => const MyLearning(),
  HomePage.routeName: (context) => const HomePage(),
  Community.routeName: (context) => const Community(),
  ChatBot.routeName: (context) => const ChatBot(),
};
