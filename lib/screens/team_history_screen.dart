import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/models/squad.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/vars.dart';
import 'package:fantasyapp/widgets/header.dart';
import 'package:fantasyapp/widgets/pickteamscreen/player_points_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TeamHistoryScreen extends StatefulWidget {
  TeamHistoryScreen({Key? key, required this.manager}) : super(key: key);
  Manager manager;

  @override
  State<TeamHistoryScreen> createState() => _TeamHistoryScreenState();
}

class _TeamHistoryScreenState extends State<TeamHistoryScreen> {
  int index = 0;

  Map<int, Future<Squad>> squadHistory = {};

  @override
  Widget build(BuildContext context) {
    AuthHelper auth = Provider.of<AuthHelper>(context);
    for (var i = 0; i < widget.manager.squadHistory.length; i++) {
      squadHistory[i] = auth.getSquad(widget.manager.squadHistory[i]);
    }
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
                        if (index < widget.manager.squadHistory.length - 1) {
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
                      child: FutureBuilder(
                          future: squadHistory[index],
                          builder: (context, AsyncSnapshot<Squad?> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        1,
                                        (index) => PlayerPointsCard(
                                              player: snapshot.data!.players[0],
                                            )),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        snapshot.data!.defNum,
                                        (index) => PlayerPointsCard(
                                              player: snapshot
                                                  .data!.players[index + 1],
                                            )),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                      snapshot.data!.midNum,
                                      (index) => PlayerPointsCard(
                                        player: snapshot.data!.players[
                                            index + snapshot.data!.defNum + 1],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                      snapshot.data!.fwdNum,
                                      (index) => PlayerPointsCard(
                                        player: snapshot.data!.players[index +
                                            snapshot.data!.defNum +
                                            snapshot.data!.midNum +
                                            1],
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Container()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        4,
                                        (index) => PlayerPointsCard(
                                              player: snapshot
                                                  .data!.players[11 + index],
                                            )),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
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
