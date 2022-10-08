import 'package:fantasyapp/models/squad.dart';
import 'package:fantasyapp/playerB.dart';
import 'package:fantasyapp/player_lab.dart';
import 'package:fantasyapp/team_lab.dart';
import 'package:flutter/material.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  LeaderboardViewState createState() => LeaderboardViewState();
}

class LeaderboardViewState extends State<LeaderboardView> {
  late List<Squad> teams, teams2;
  late List<PlayerB> players, players2;

  @override
  void initState() {
    super.initState();
    teams = TeamLab.get().teams;
    teams2 = List.from(teams);
    players = PlayerLab.get().players;
    players2 = List.from(players);

    teams.sort((Squad a, Squad b) {
      return a.points.compareTo(b.points);
    });
    teams2.sort((Squad a, Squad b) {
      return b.pointsWeek.compareTo(a.pointsWeek);
    });

    players.sort((PlayerB a, PlayerB b) {
      return a.points.compareTo(b.points);
    });
    players2.sort((PlayerB a, PlayerB b) {
      return b.pointsWeek.compareTo(a.pointsWeek);
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text("Overall Leadearboard"),
          Container(
            color: Colors.amber,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/first.png",
                      height: 100.0,
                    ),
                    Text(teams[teams.length - 1].points.toString()),
                    Text(teams[teams.length - 1].pointsWeek.toString())
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(teams[teams.length - 1].name),
                    Text(teams[teams.length - 1].owner),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white70,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/second.png",
                            height: 100.0,
                          ),
                          Text(teams[teams.length - 2].points.toString()),
                          Text(teams[teams.length - 2].pointsWeek.toString())
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(teams[teams.length - 2].name),
                          Text(teams[teams.length - 2].owner),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.brown,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/third.png",
                              height: 100.0,
                            ),
                            Text(teams[teams.length - 3].points.toString()),
                            Text(teams[teams.length - 3].pointsWeek.toString())
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(teams[teams.length - 3].name),
                            Text(teams[teams.length - 3].owner),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
          const Text("Weekly Leadearboard"),
          Container(
            color: Colors.amber,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/first.png",
                      height: 100.0,
                    ),
                    Text(teams2[0].points.toString()),
                    Text(teams2[0].pointsWeek.toString())
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(teams2[0].name),
                    Text(teams2[0].owner),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white70,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/second.png",
                            height: 100.0,
                          ),
                          Text(teams2[1].points.toString()),
                          Text(teams2[1].pointsWeek.toString())
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(teams2[1].name),
                          Text(teams2[1].owner),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.brown,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/third.png",
                              height: 100.0,
                            ),
                            Text(teams2[2].points.toString()),
                            Text(teams2[2].pointsWeek.toString())
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(teams2[2].name),
                            Text(teams2[2].owner),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: 'Teams',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Players',
            )
          ]),
    );
  }
}
