import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microsoft/auth_page/login_screen.dart';
import 'package:microsoft/helper/helper_fun.dart';
import 'package:microsoft/screens/home.dart';

import 'utils/routes_setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    getStatus();
    super.initState();
  }

  Future getStatus() async {
    await Helper.getLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women World',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      home: _isSignedIn ? const HomePage() : const LoginScreen(),
      routes: routeSettings,
    );
  }
}
