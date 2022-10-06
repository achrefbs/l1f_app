import 'package:fantasyapp/internet_async.dart';
import 'package:fantasyapp/playerB.dart';
import 'package:fantasyapp/player_creation_details_view.dart';
import 'package:fantasyapp/team.dart';
import 'package:flutter/material.dart';

class CreateTeamView extends StatefulWidget {
  final List<PlayerB> selectedPlayers;

  CreateTeamView({
    super.key,
    players,
    selectedPlayers,
  }) : selectedPlayers = (selectedPlayers == null)
            ? List<PlayerB>.generate(
                16,
                (int index) => PlayerB.empty(),
              )
            : selectedPlayers;

  @override
  CreateTeamViewState createState() => CreateTeamViewState();
}

class CreateTeamViewState extends State<CreateTeamView> {
  final double _checkboxHeight = 30.0;
  final double _startingBudget = 100.0;
  double _budget = 100.0;
  bool _maxThreeSameTeam = true, _isTeamNameLong = false, _buttonEnabled = true;
  String _teamName = "";
  Widget _saveChanges = const Text("Press to save changes");

  @override
  void initState() {
    Map<int, int> teamCount = <int, int>{};
    int fresherCount = 0;
    for (PlayerB player in widget.selectedPlayers) {
      _budget -= player.price;
      if (player.isFresher) fresherCount++;
      if (teamCount[player.team] == null) {
        teamCount[player.team] = 1;
      } else {
        teamCount[player.team]! + 1;
        if (teamCount[player.team]! > 3) _maxThreeSameTeam = false;
      }
    }

    super.initState();
  }

  emptyPlayer(int index) {
    PlayerB player = widget.selectedPlayers[index];
    Widget playerView;

    if (player == null) {
      playerView = Image.asset(
        "assets/shirt_blank.png",
        fit: BoxFit.fitHeight,
      );
    } else {
      playerView = Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              player.image,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            color: Colors.green,
            child: Text(
              "${player.firstName.substring(0, 1)}. ${player.lastName}",
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          Container(
            color: Colors.green,
            child: Text("£${player.price}m", textAlign: TextAlign.center),
          ),
        ],
      );
    }

    return Expanded(
      child: InkWell(
          onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return PlayersCreationDetailsView(
                  selectedPlayers: widget.selectedPlayers,
                  playerIndex: index,
                );
              })),
          child: Padding(
            padding: const EdgeInsets.only(left: 3.0, right: 3.0),
            child: playerView,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Create your team"),
            ),
            body: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Stack(children: <Widget>[
                      Positioned.fill(
                          child: Image.asset(
                        "assets/pitch.jpg",
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topLeft,
                      ))
                    ])),
                  ],
                ),
                Column(
                  //players
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                List.generate(2, (index) => emptyPlayer(index)),
                          ),
                        )),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              5, (index) => emptyPlayer(index + 2)),
                        )),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              5, (index) => emptyPlayer(index + 7)),
                        )),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              4, (index) => emptyPlayer(index + 12)),
                        )),
                    Expanded(flex: 1, child: Container()),
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: Row(
                              children: <Widget>[
                                const Expanded(
                                  child: Text(
                                    "Remaining Budget",
                                  ),
                                ),
                                Text(
                                  "£${_budget}m",
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: TextField(
                                  onChanged: (string) {
                                    if (string.length >= 4) {
                                      _teamName = string;
                                      setState(() {
                                        _isTeamNameLong = true;
                                      });
                                    } else {
                                      setState(() {
                                        _isTeamNameLong = false;
                                      });
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Team Name",
                                  ),
                                )),
                                SizedBox(
                                  height: _checkboxHeight,
                                  child: Checkbox(
                                    value: _isTeamNameLong,
                                    onChanged: (b) {},
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                        height: 50.0,
                        minWidth: double.infinity,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: _saveChanges,
                        onPressed: () {
                          if (_buttonEnabled) {
                            String message = "";
                            if (!_maxThreeSameTeam) {
                              message +=
                                  "You can have at most 3 players from the same team \n";
                            }
                            if (!_isTeamNameLong) {
                              message +=
                                  "Your team name must be at least 4 characters long \n";
                            }
                            if (_budget < 0) {
                              message += "You can't exceed the budget \n";
                            }

                            if (message != "") {
                              final snackBar = SnackBar(
                                  content: Text(message),
                                  duration: const Duration(seconds: 2));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              setState(() {
                                _saveChanges = FutureBuilder(
                                  future: InternetAsync().addTeam(
                                      context,
                                      TeamB.fromSelectedList(
                                          widget.selectedPlayers,
                                          _teamName,
                                          "UserB.get()!.username",
                                          _startingBudget - _budget)),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      _buttonEnabled = true;
                                      return const Text(
                                          "Press to save changes");
                                    }
                                    // By default, show a loading spinner and disable button
                                    _buttonEnabled = false;
                                    return const CircularProgressIndicator();
                                  },
                                );
                              });
                            }
                          }
                        }),
                  ],
                ),
              ],
            )));
  }
}
