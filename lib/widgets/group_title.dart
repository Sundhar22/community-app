// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:microsoft/theme/colors.dart';
import 'package:microsoft/utils/sizeconfig.dart';
import 'package:microsoft/utils/utils.dart';
import 'package:microsoft/widgets/chat_screens.dart';

class GroupTitle extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String groupDescription;

  const GroupTitle({
    Key? key,
    required this.userName,
    required this.groupId,
    required this.groupName,
    required this.groupDescription,
  }) : super(key: key);

  @override
  State<GroupTitle> createState() => _GroupTitleState();
}

class _GroupTitleState extends State<GroupTitle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nextScreen(
            context,
            ChatScreen(
                groupId: widget.groupId,
                groupName: widget.groupName,
                userName: widget.userName));
      },
      child: Container(
        margin: EdgeInsets.all(screenHeight(10)),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(screenWidth(15))),
        padding: EdgeInsets.symmetric(
            vertical: screenHeight(10), horizontal: screenWidth(5)),
        child: ListTile(
          leading: CircleAvatar(
            radius: screenWidth(30),
            backgroundColor: green,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              style: TextStyle(
                  color: blue,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight(20)),
            ),
          ),
          title: Text(widget.groupName),
          subtitle: Text('Join the conversion ${widget.groupName}'),
        ),
      ),
    );
  }
}
