import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/models/squad.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/vars.dart';
import 'package:fantasyapp/widgets/header.dart';
import 'package:fantasyapp/widgets/pickteamscreen/player_points_card.dart';
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

  Map<int, Squad> squadHistoryE = {
    0: Squad(0, "name", "owner", 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0),
    1: Squad(0, "name", "owner", 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0),
    2: Squad(0, "name", "owner", 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0),
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                1,
                                (index) => PlayerPointsCard(
                                      player: widget.manager.squad.players[0],
                                    )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                widget.manager.squad.defNum,
                                (index) => PlayerPointsCard(
                                      player: widget
                                          .manager.squad.players[index + 1],
                                    )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              widget.manager.squad.midNum,
                              (index) => PlayerPointsCard(
                                player: widget.manager.squad.players[
                                    index + widget.manager.squad.defNum + 1],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                widget.manager.squad.fwdNum,
                                (index) => PlayerPointsCard(
                                      player: widget.manager.squad.players[
                                          index +
                                              widget.manager.squad.defNum +
                                              widget.manager.squad.midNum +
                                              1],
                                    )),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                4,
                                (index) => PlayerPointsCard(
                                      player: widget
                                          .manager.squad.players[11 + index],
                                    )),
                          ),
                          const SizedBox(height: 50),
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
