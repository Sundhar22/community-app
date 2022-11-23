// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microsoft/auth_page/login_screen.dart';
import 'package:microsoft/helper/helper_fun.dart';
import 'package:microsoft/service/database_service.dart';
import 'package:microsoft/service/firebase_auth_service.dart';
import 'package:microsoft/theme/colors.dart';
import 'package:microsoft/utils/sizeconfig.dart';
import 'package:microsoft/widgets/chat_screens.dart';

import '../screens/home.dart';
import '../utils/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String userName = '';

  User? user;

  bool isJoined = false;

  @override
  void initState() {
    getCurrentUserId();
    super.initState();
  }

  getCurrentUserId() async {
    await Helper.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  bool isLoading = false;
  QuerySnapshot? searchQuery;
  bool hasSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // const Divider(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(10), vertical: screenHeight(12)),
            child: Row(children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: _controller,
                  style: const TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            initiateSearchMethod();
                          },
                          child: const Icon(Icons.search)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth(10)))),
                      hintText: 'search a community',
                      hintStyle: TextStyle(color: green)),
                ),
              )
            ]),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : groupList(),
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    await DataBaseService().searchByName(_controller.text).then((snapshot) {
      setState(() {
        isLoading = false;
        searchQuery = snapshot;
        hasSearch = true;
      });
    });
  }

  groupList() {
    return hasSearch
        ? Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchQuery!.docs.length,
              itemBuilder: (context, index) {
                return _groupTitle(
                  userName,
                  searchQuery!.docs[index]['groupId'],
                  searchQuery!.docs[index]['groupName'],
                  searchQuery!.docs[index]['admin'],
                );
              },
            ),
          )
        : Container();
  }

  joinedOrNot(
      String userName, String groupId, String groupname, String admin) async {
    await DataBaseService(uid: user!.uid)
        .isUserJoined(groupname, groupId, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
    return;
  }

  _groupTitle(String userName, String groupId, String groupName, String admin) {
    joinedOrNot(userName, groupId, groupName, admin);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title:
          Text(groupName, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text("Admin: ${getName(admin)}"),
      trailing: InkWell(
        onTap: () async {
          await DataBaseService(uid: user!.uid)
              .groupJoinExit(groupId, userName, groupName);
          if (isJoined) {
            setState(() {
              isJoined = !isJoined;
            });
            showSnackbar(context, green, 'Successfully joined');
            Future.delayed(const Duration(seconds: 1), () {
              nextScreen(
                  context,
                  ChatScreen(
                      groupId: groupId,
                      groupName: groupName,
                      userName: userName));
            });
          } else {
            setState(() {
              isJoined = !isJoined;
              showSnackbar(context, Colors.red, 'you left the group');
            });
          }
        },
        child: isJoined
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(10), vertical: screenHeight(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    color: Colors.black,
                    border: Border.all(color: white, width: 1)),
                child: Text(
                  'Joined',
                  style: TextStyle(
                    color: white,
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(10), vertical: screenHeight(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    color: Colors.black,
                    border: Border.all(color: white, width: 1)),
                child: Text(
                  'Join..',
                  style: TextStyle(
                    color: white,
                  ),
                ),
              ),
      ),
    );
  }

  String getName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }
}
