import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microsoft/service/database_service.dart';
import 'package:microsoft/theme/colors.dart';
import 'package:microsoft/utils/sizeconfig.dart';
import 'package:microsoft/utils/utils.dart';
import 'package:microsoft/widgets/info_screen.dart';
import 'package:microsoft/widgets/mesage_tile.dart';

class ChatScreen extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatScreen(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chats;

  String adminName = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    getChatAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            widget.groupName,
            style: TextStyle(color: green),
          ),
          foregroundColor: blue,
          actions: [
            IconButton(
                onPressed: () {
                  nextScreen(
                      context,
                      InfoScreen(
                        groupId: widget.groupId,
                        groupName: widget.groupName,
                        groupAdmin: adminName,
                      ));
                },
                icon: const Icon(CupertinoIcons.info))
          ],
        ),
        body: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth(5), vertical: screenHeight(10)),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(20), vertical: screenHeight(5)),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.grey[500],
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'send a message',
                          hintStyle: TextStyle(color: white)),
                    )),
                    SizedBox(
                      width: screenWidth(12),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        height: screenHeight(25),
                        width: screenWidth(25),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth(50))),
                        child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  sendMessage() {
    if (_controller.text.isNotEmpty) {
      Map<String, dynamic> chatMessagesMap = {
        'message': _controller.text,
        'sender': widget.userName,
        'time': DateTime.now().millisecondsSinceEpoch
      };

      DataBaseService().sendMessage(widget.groupId, chatMessagesMap);
      setState(() {
        _controller.clear();
      });
    }
  }

  getChatAdmin() {
    DataBaseService().getChats(widget.groupId).then((value) {
      setState(() {
        chats = value;
      });
    });
    DataBaseService().getGroupAdmin(widget.groupId).then((value) {
      adminName = value;
    });
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }
}
