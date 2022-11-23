import 'package:flutter/material.dart';
import 'bot_message_container.dart';
import 'user_message_container.dart';
// ignore: must_be_immutable
class ReplyPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Problem;
  // ignore: non_constant_identifier_names
  List Advices;
  ReplyPage({
    super.key,
    // ignore: non_constant_identifier_names
    required this.Problem,
    // ignore: non_constant_identifier_names
    required this.Advices,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 55,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserMessageContainer(
                Message: 'I want assistance in $Problem issues',
              ),
              const BotMessageContainer(
                Message: "Sure will do the nessecary",
              ),
              const BotMessageContainer(
                  Message: "How about you try some of the following ?"),
              for (int i = 0; i < Advices.length; i++)
                BotMessageContainer(Message: Advices[i]),
              const UserMessageContainer(
                Message: 'Thanks a lot',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
