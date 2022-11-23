import 'package:flutter/material.dart';

class UserMessageContainer extends StatelessWidget {
  final Message;
  const UserMessageContainer({
    super.key,
    required this.Message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
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
