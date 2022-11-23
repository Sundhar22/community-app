import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microsoft/service/database_service.dart';
import 'package:microsoft/service/firebase_auth_service.dart';
import 'package:microsoft/theme/colors.dart';
import 'package:microsoft/utils/sizeconfig.dart';
import 'package:microsoft/utils/utils.dart';
import 'package:microsoft/widgets/chat_screens.dart';
import 'package:microsoft/widgets/group_title.dart';
import 'package:microsoft/widgets/search_page.dart';

import '../helper/helper_fun.dart';
import '../utils/enums.dart';
import '../utils/navigator.dart';

class Community extends StatefulWidget {
  static String routeName = 'community';
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  Stream? group;
  Stream? communityStream;

  bool isLoading = false;
  String userName = '';
  String email = '';

  String?groupName;

  String? groupDescription;
  String description = '';

  String ID = '';
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  getGroupDescription() {
    DataBaseService().getGroupDescription(ID).then((value) {
      setState(() {
        description = value;
      });
    });
  }

//  String manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }

  getUserData() async {
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

    await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .userGroup()
        .then((snapshot) {
      setState(() {
        group = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              nextScreen(context, const SearchScreen());
            },
            icon: Icon(
              Icons.search,
              color: blue,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                popUpDialog(context);
              },
              icon: Icon(
                Icons.group_add_outlined,
                color: blue,
              ))
        ],
        title: Text(
          'Community',
          style: TextStyle(color: green, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              thickness: screenHeight(1),
            ),
            groupLists(context),
          ],
        ),
      ),
      bottomNavigationBar:
          const NavigationContainer(chose: MenuState.community),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Create a new group',
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  groupName = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter groupName',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(screenWidth(15))),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.circular(screenWidth(15))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: green),
                                    borderRadius:
                                        BorderRadius.circular(screenWidth(15))),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(30),
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  groupDescription = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter groupDescription',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(screenWidth(15))),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.circular(screenWidth(15))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: green),
                                    borderRadius:
                                        BorderRadius.circular(screenWidth(15))),
                              ),
                            ),
                          ],
                        )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      if (groupName != null && groupDescription != null) {
                        setState(() {});
                        DataBaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                userName,
                                FirebaseAuth.instance.currentUser!.uid,
                                groupName!,
                                groupDescription!)
                            .whenComplete(() {
                          isLoading = false;
                        });

                        Navigator.of(context).pop();
                        showSnackbar(
                            context, green, 'Successfully community created');
                      }
                    },
                    child: const Text('Create'))
              ],
            );
          },
        );
      },
    );
  }

  groupLists(BuildContext context) {
    return StreamBuilder(
      stream: group,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return SizedBox(
                height: screenHeight(630),
                child: ListView.builder(
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        snapshot.data['groups'].length - index - 1;
                    ID = getId(snapshot.data['groups'][reverseIndex]);
                    return GroupTitle(
                      userName: snapshot.data['userName'],
                      groupId: getId(snapshot.data['groups'][reverseIndex]),
                      groupName: getName(snapshot.data['groups'][reverseIndex]),
                      groupDescription: description,
                    );
                  },
                ),
              );
            } else {
              return noGroup();
            }
          } else {
            return noGroup();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  noGroup() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenWidth(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => popUpDialog(context),
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: screenHeight(75),
            ),
          ),
          SizedBox(
            height: screenHeight(10),
          ),
          Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            style: TextStyle(color: yellow),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
