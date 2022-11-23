import 'package:flutter/material.dart';
import 'package:microsoft/utils/sizeconfig.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;

  const MessageTile(
      {super.key,
      required this.message,
      required this.sender,
      required this.sentByMe});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: screenHeight(4),
          bottom: screenHeight(4),
          left: widget.sentByMe ? 0 : screenWidth(4),
          right: widget.sentByMe ? screenWidth(24) : 0),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: screenHeight(17),
            bottom: screenHeight(17),
            left: screenWidth(20),
            right: screenWidth(20)),
        decoration: BoxDecoration(
            borderRadius: widget.sentByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(screenWidth(20)),
                    topRight: Radius.circular(screenWidth(20)),
                    bottomLeft: Radius.circular(screenWidth(20)),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(screenWidth(20)),
                    topRight: Radius.circular(screenWidth(20)),
                    bottomRight: Radius.circular(screenWidth(20)),
                  ),
            color: widget.sentByMe
                ? Theme.of(context).primaryColor
                : Colors.grey[700]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender.toUpperCase(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(widget.message,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 16, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
