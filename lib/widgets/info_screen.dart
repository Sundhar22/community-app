import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:microsoft/auth_page/login_screen.dart';
import 'package:microsoft/screens/community.dart';
import 'package:microsoft/utils/sizeconfig.dart';
import 'package:microsoft/utils/utils.dart';

import '../service/database_service.dart';
import '../theme/colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen(
      {super.key,
      required this.groupName,
      required this.groupAdmin,
      required this.groupId});
  final String groupName;
  final String groupAdmin;
  final String groupId;
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Stream? members;

  String getName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((val) {
      setState(() {
        members = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Community Info',
          style: TextStyle(color: green),
        ),
        foregroundColor: green,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Exit"),
                        content: const Text("Are you sure you want to exit?"),
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
                              DataBaseService(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .groupJoinExit(
                                      widget.groupId,
                                      getName(widget.groupAdmin),
                                      widget.groupName)
                                  .whenComplete(() {
                                nextScreenReplace(context, const Community());
                              });
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
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: green,
                  radius: screenWidth(15),
                  child: Text(
                    widget.groupName.substring(0, 1).toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w500, color: blue),
                  ),
                ),
                SizedBox(
                  width: screenWidth(20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Group: ${widget.groupName}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: screenHeight(10),
                    ),
                    Text(
                      'Admin: ${getName(widget.groupAdmin)}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight(10)),
            Text(
              'Members',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: screenHeight(20)),
            ),
            memberList(),
          ],
        ),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(20),
                        vertical: screenHeight(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: green,
                        radius: screenHeight(30),
                        child: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      title: Text(getName(snapshot.data['members'][index])),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No member'),
              );
            }
          } else {
            return const Center(
              child: Text('No member'),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
