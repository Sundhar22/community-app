import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:microsoft/widgets/globals.dart' as globals;

import 'chat_bot_reply.dart';
class ChatBotCard extends StatelessWidget {
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  final Title;

  const ChatBotCard({
    Key? key,
    required this.Title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: 145,
      width: 165,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(
                1.0,
                1.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 5.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              children: [
                Text(
                  "$Title \nIssues",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      letterSpacing: .9,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 6,
                ),
                child: IconButton(
                  onPressed: () {
                    if (Title == "Physical") {
                      //
                      globals.GeneratedAdvices = globals.Advices["Physical"];
                      //
                    } else if (Title == "Mental") {
                      //
                      print("Mental Initialise");
                      globals.GeneratedAdvices.addAll(
                          globals.Advices["Isolation"]);
                      globals.GeneratedAdvices.addAll(
                          globals.Advices["Depression"]);
                      //
                    } else if (Title == "Harasmment") {
                      //

                      globals.GeneratedAdvices = [
                        "child Helpline : 1098",
                        "women Helpline: 1091",
                        "suicide Helpline: 988",
                        "mental Helpline : 14416",
                        "Abuse Helpline  : 181",
                        "Depression Helpline : 4357",
                        "Cyber Helpline : 155620",
                        "Health Helpline : 104",
                      ];

                      print(globals.GeneratedAdvices);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReplyPage(
                          Problem: Title,
                          Advices: globals.GeneratedAdvices,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_circle_right,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
