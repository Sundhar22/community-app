// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:microsoft/auth_page/login_screen.dart';
import 'package:microsoft/helper/helper_fun.dart';
import 'package:microsoft/screens/home.dart';
import 'package:microsoft/utils/constant.dart';

import '../service/firebase_auth_service.dart';
import '../utils/sizeconfig.dart';
import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  // final VoidCallback onClickRegister;
  const SignUpScreen({
    Key? key,
    // required this.onClickRegister,
  }) : super(key: key);
  static String routeName = 'sign up';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  bool isLogin = false;

  FirebaseAuthService authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
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
                        child: Image.asset(""),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome to NASA! ",
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
                                  'Keep your data safe!',
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
                          controller: nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null) {
                              return null;
                            } else {
                              return 'enter correct user name';
                            }
                          },
                          cursorHeight: screenHeight(25),
                          textInputAction: TextInputAction.next,
                          decoration: reuseDecoration(Icons.person, 'name')),
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
                        decoration: reuseDecoration(Icons.mail, 'email'),
                      ),
                      SizedBox(height: screenHeight(15)),
                      TextFormField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) => val != null && val.length < 6
                            ? 'Enter more than 5 character'
                            : null,
                        controller: passwordController,
                        cursorHeight: screenHeight(25),
                        textInputAction: TextInputAction.done,
                        decoration: reuseDecoration(Icons.lock, 'password'),
                      ),
                      SizedBox(height: screenHeight(20)),
                      InkWell(
                        onTap: signUp,
                        child: Container(
                          height: screenHeight(60),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.circular(screenWidth(12)),
                          ),
                          child: Center(
                              child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight(16),
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      SizedBox(height: screenHeight(15)),
                      RichText(
                          text: TextSpan(
                              text: "Already have an account?",
                              style: TextStyle(
                                  color: Colors.grey.shade700, wordSpacing: 2),
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const LoginScreen());
                                  },
                                text: "Login",
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

  Future signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLogin = true;
      });
    }

    await authService
        .registerUserWithEmailAndPassword(
            nameController.text, passwordController.text, emailController.text)
        .then((value) async {
      if (value == true) {
        // saving the shared preference state
        await Helper.setUserLoggedInStatus(true);
        await Helper.setUserEmailInStatus(emailController.text);
        await Helper.setUserNameInStatus(nameController.text);

        

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
