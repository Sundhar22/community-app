// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BotMessageContainer extends StatelessWidget {
  final Message;

  const BotMessageContainer({
    super.key,
    required this.Message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
          bottom: 10,
          top: 5,
        ),
        width: 220,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(
            Radius.circular(
              25,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(
            12,
          ),
          child: Text(
            Message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
