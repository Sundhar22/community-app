// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:microsoft/service/database_service.dart';

import '../helper/helper_fun.dart';
import '../screens/home.dart';
import '../service/firebase_auth_service.dart';
import '../theme/colors.dart';
import '../utils/sizeconfig.dart';
import '../utils/utils.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool viewpass = true;
  final formKey = GlobalKey<FormState>();
  FirebaseAuthService authService = FirebaseAuthService();
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);

    return Scaffold(
      body: isLogin
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight(15)),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight(40)),
                      SizedBox(
                        height: screenHeight(250),
                        width: screenWidth(400),
                        child: Image.asset("assets/images/login.jpg"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome back ! ",
                                style: TextStyle(
                                    wordSpacing: screenWidth(5),
                                    letterSpacing: screenWidth(1),
                                    color: Colors.black,
                                    fontSize: screenHeight(18),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenHeight(4)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth(15)),
                                child: Text(
                                  'Login to see what the features in ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: screenHeight(15)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight(25)),
                      TextFormField(
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                        cursorHeight: screenHeight(25),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail,
                              color: Colors.black.withOpacity(.7)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenWidth(20)))),
                          hintText: 'Email',
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth(20))),
                            borderSide: BorderSide(color: green, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth(20))),
                            borderSide: BorderSide(color: blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth(20))),
                            borderSide: const BorderSide(
                                color: Color(0xFFee7b64), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(15)),
                      TextFormField(
                        obscureText: viewpass,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) => val != null && val.length < 6
                            ? 'Enter more than 5 character'
                            : null,
                        controller: passwordController,
                        cursorHeight: screenHeight(25),
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black.withOpacity(.7),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenWidth(20)))),
                          hintText: 'Password',
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth(20))),
                            borderSide: BorderSide(color: green, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth(20))),
                            borderSide: BorderSide(color: blue, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth(20))),
                            borderSide: const BorderSide(
                                color: Color(0xFFee7b64), width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(20)),
                      InkWell(
                        onTap: login,
                        child: Container(
                          height: screenHeight(60),
                          decoration: BoxDecoration(
                            color: green,
                            borderRadius:
                                BorderRadius.circular(screenWidth(12)),
                          ),
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(
                                color: white,
                                fontSize: screenHeight(16),
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      SizedBox(height: screenHeight(10)),
                      SizedBox(
                        height: screenHeight(170),
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.grey.shade700, wordSpacing: 2),
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.popAndPushNamed(
                                      context, SignUpScreen.routeName),
                                text: " Register!",
                                style: const TextStyle(
                                  color: Colors.blue,
                                ))
                          ]))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLogin = true;
      });
    }

    await authService
        .loginUserNameWithEmailAndPassword(
            passwordController.text, emailController.text)
        .then((value) async {
      if (value == true) {
        QuerySnapshot snapshot =
            await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .getUserData(emailController.text.trim());

        await Helper.setUserLoggedInStatus(true);
        await Helper.setUserEmailInStatus(emailController.text);
        await Helper.setUserNameInStatus(snapshot.docs[0]['userName']);

        Navigator.popAndPushNamed(context, HomePage.routeName);
        
      } else {
        showSnackbar(context, Colors.red, value);
        setState(() {
          isLogin = false;
        });
      }
    });
  }
}
