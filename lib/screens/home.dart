import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microsoft/helper/helper_fun.dart';
import 'package:microsoft/theme/colors.dart';
import 'package:microsoft/utils/sizeconfig.dart';

import '../auth_page/login_screen.dart';
import '../service/firebase_auth_service.dart';
import '../utils/enums.dart';
import '../utils/navigator.dart';
import '../utils/utils.dart';
import '../widgets/search_page.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String email = '';

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  getDetails() async {
    await Helper.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await Helper.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return SafeArea(
      child: Scaffold(
        drawer: appDrawer(context, userName, FirebaseAuthService()),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth(40)),
              height: screenHeight(250),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(screenHeight(50)),
                    bottomRight: Radius.circular(screenHeight(50)),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello,",
                            style: TextStyle(
                              color: white,
                              fontSize: screenHeight(25),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Good Morning,",
                            style: TextStyle(
                              color: white,
                              fontSize: screenHeight(20),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: white.withOpacity(.3)),
                        child: Icon(
                          Icons.notifications,
                          color: white,
                          size: screenHeight(27),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight(40)),
                  Container(
                      padding: EdgeInsets.all(screenWidth(5)),
                      height: screenHeight(50),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius:
                              BorderRadius.circular(screenHeight(25))),
                      child: TextField(
                        cursorHeight: screenHeight(20),
                        autocorrect: true,
                        decoration: const InputDecoration(
                          hintText: 'Search your topic',
                          border: InputBorder.none,
                          prefixIcon: Icon(CupertinoIcons.search),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavigationContainer(
          chose: MenuState.favorites,
        ),
      ),
    );
  }
}
Widget appDrawer(
  BuildContext context,
  String userName,
  FirebaseAuthService authService,
) {
  return Drawer(
      child: ListView(
    padding: const EdgeInsets.symmetric(vertical: 50),
    children: <Widget>[
      Icon(
        Icons.account_circle,
        size: screenHeight(150),
        color: Colors.grey[700],
      ),
      SizedBox(
        height: screenHeight(15),
      ),
      Text(
        userName,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: screenHeight(30),
      ),
      Divider(
        height: screenHeight(2),
      ),
      ListTile(
        onTap: () {
          nextScreen(context, const HomePage());
        },
        contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth(30), vertical: screenHeight(5)),
        leading: const Icon(Icons.group),
        title: const Text(
          "Groups",
          style: TextStyle(color: Colors.black),
        ),
      ),
      ListTile(
        onTap: () {},
        selected: true,
        selectedColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth(30), vertical: screenHeight(5)),
        leading: const Icon(Icons.group),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      ListTile(
        onTap: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await authService.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ),
                  ],
                );
              });
        },
        contentPadding: EdgeInsets.symmetric(
            horizontal: screenHeight(30), vertical: screenHeight(5)),
        leading: const Icon(Icons.exit_to_app),
        title: const Text(
          "Logout",
          style: TextStyle(color: Colors.black),
        ),
      )
    ],
  ));
}
