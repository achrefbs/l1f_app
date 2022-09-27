import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/vars.dart';
import 'package:fantasyapp/widgets/header.dart';
import 'package:fantasyapp/widgets/pickteamscreen/attack_line.dart';
import 'package:fantasyapp/widgets/pickteamscreen/defence_line.dart';
import 'package:fantasyapp/widgets/pickteamscreen/goal_line.dart';
import 'package:fantasyapp/widgets/pickteamscreen/mid_line.dart';
import 'package:fantasyapp/widgets/pickteamscreen/subtitute_line.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TeamHistoryScreen extends StatefulWidget {
  TeamHistoryScreen({Key? key, required this.manager}) : super(key: key);
  Manager manager;

  @override
  State<TeamHistoryScreen> createState() => _TeamHistoryScreenState();
}

class _TeamHistoryScreenState extends State<TeamHistoryScreen> {
  int index = 0;

  Map<int, Map<String, dynamic>> squadHistoryE = {
    0: {
      "gk": "0",
      "def": ["0", "0", "0"],
      "mid": ["0", "0", "0", "0"],
      "att": ["0", "0", "0"],
      "subs": ["0", "0", "0"],
      "captain": "0",
    },
    1: {
      "gk": "0",
      "def": ["0", "0", "0"],
      "mid": ["0", "0", "0", "0"],
      "att": ["0", "0", "0"],
      "subs": ["0", "0", "0"],
      "captain": "0",
    }
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              HeaderWidget(
                title: 'Pick Team',
                navigateTo: const HomeScreen(),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: kBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (index > 0) {
                          setState(() {
                            index--;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white24,
                      ),
                    ),
                    Text(
                      "Gameweek $index",
                      style: const TextStyle(color: kBarTextColor),
                    ),
                    IconButton(
                      onPressed: () {
                        if (index < squadHistoryE.length - 1) {
                          setState(() {
                            index++;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: kBarTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: kSnackBarColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: const [
                    Icon(
                      Icons.compare_arrows,
                      color: kSnackBarTextColorPrimary,
                    ),
                    SizedBox(width: 8),
                    Text('Transfer deadline:',
                        style: TextStyle(color: kSnackBarTextColorPrimary)),
                    SizedBox(width: 8),
                    Text(
                      '28 Sep, 20:00',
                      style: TextStyle(color: kSnackBarTextColorSecondary),
                    )
                  ]),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/pitch22.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          GoadLine(
                            playerID: "0",
                          ),
                          const SizedBox(height: 20),
                          const DefenceLine(),
                          const SizedBox(height: 20),
                          const MidLine(),
                          const SizedBox(height: 20),
                          const AttackLine(),
                          const SizedBox(height: 110),
                          const SubstituteLine(),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kTransparentBackgroundColor,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "+ Chips",
                            style: TextStyle(color: kBarTextColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
