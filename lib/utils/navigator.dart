import 'package:flutter/material.dart';
import 'package:microsoft/screens/chat_bot.dart';
import 'package:microsoft/screens/community.dart';
import 'package:microsoft/screens/home.dart';
import 'package:microsoft/screens/my_learning.dart';
import 'package:microsoft/utils/enums.dart';

import 'package:microsoft/utils/sizeconfig.dart';

import '../theme/colors.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({
    Key? key,
    required this.chose,
  }) : super(key: key);
  final Enum chose;

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Container(
      color: Colors.white,
      height: screenHeight(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.popAndPushNamed(context, HomePage.routeName);
                    });
                  },
                  icon: Icon(
                    Icons.star_outline_rounded,
                    size: MenuState.favorites == widget.chose
                        ? screenHeight(35)
                        : screenHeight(25),
                    color: MenuState.favorites == widget.chose
                        ? blue
                        : Colors.grey,
                  )),
              Text(
                "Featured",
                style: TextStyle(
                  fontWeight: MenuState.favorites == widget.chose
                      ? FontWeight.bold
                      : null,
                  color:
                      MenuState.favorites == widget.chose ? blue : Colors.grey,
                ),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.popAndPushNamed(context, MyLearning.routeName);
                    });
                  },
                  icon: Icon(
                    size: MenuState.myLearning == widget.chose
                        ? screenHeight(35)
                        : screenHeight(25),
                    Icons.play_circle_outline,
                    color: MenuState.myLearning == widget.chose
                        ? blue
                        : Colors.grey,
                  )),
              Text(
                "My learning",
                style: TextStyle(
                  fontWeight: MenuState.myLearning == widget.chose
                      ? FontWeight.bold
                      : null,
                  color:
                      MenuState.myLearning == widget.chose ? blue : Colors.grey,
                ),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.popAndPushNamed(context, Community.routeName);
                    });
                  },
                  icon: Icon(
                    size: MenuState.community == widget.chose
                        ? screenHeight(35)
                        : screenHeight(25),
                    Icons.group_rounded,
                    color: MenuState.community == widget.chose
                        ? blue
                        : Colors.grey,
                  )),
              Text(
                "Community",
                style: TextStyle(
                  fontWeight: MenuState.community == widget.chose
                      ? FontWeight.bold
                      : null,
                  color:
                      MenuState.community == widget.chose ? blue : Colors.grey,
                ),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.popAndPushNamed(context, ChatBot.routeName);
                    });
                  },
                  icon: Icon(
                    size: MenuState.chartBot == widget.chose
                        ? screenHeight(35)
                        : screenHeight(25),
                    Icons.chat,
                    color:
                        MenuState.chartBot == widget.chose ? blue : Colors.grey,
                  )),
              Text(
                "chartBot",
                style: TextStyle(
                  fontWeight: MenuState.chartBot == widget.chose
                      ? FontWeight.bold
                      : null,
                  color:
                      MenuState.chartBot == widget.chose ? blue : Colors.grey,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
