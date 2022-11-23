import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:microsoft/widgets/globals.dart'as globals;

import '../utils/enums.dart';
import '../utils/navigator.dart';
import '../widgets/chat_bot_card.dart';

class ChatBot extends StatefulWidget {
  static String routeName = 'chatBot';
  const ChatBot({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    print("From Main Page : ${globals.GeneratedAdvices}");
    globals.GeneratedAdvices = [];
    print("From Main Page : ${globals.GeneratedAdvices.length}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                top: 65,
              ),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 25,
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome Back Diva !!',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          letterSpacing: .9,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      'Choose your issue from the cards below',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          letterSpacing: .9,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Center(
            //   child: Lottie.asset(
            //     height: 280,
            //     ("images/chat.json"),
            //   ),
            // ),
            const Text(
              'Ready for the assist !',
              style:  TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Pcik a topic to know more !',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const <Widget>[
                  ChatBotCard(
                    Title: 'Mental',
                  ),
                  ChatBotCard(
                    Title: 'Physical',
                  ),
                  ChatBotCard(
                    Title: 'Harasmment',
                  ),
                  ChatBotCard(
                    Title: 'Education',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationContainer(chose: MenuState.chartBot),
    );
  }
}
