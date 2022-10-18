import 'package:fantasyapp/models/player.dart';
import 'package:fantasyapp/player_creation_details_view.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/vars.dart';
import 'package:fantasyapp/widgets/header.dart';
import 'package:fantasyapp/widgets/pickteamscreen/player_points_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTeamView extends StatefulWidget {
  final List<Player> selectedPlayers;

  CreateTeamView({
    super.key,
    selectedPlayers,
  }) : selectedPlayers = (selectedPlayers == null)
            ? List<Player>.generate(
                16,
                (int index) => Player.empty(),
              )
            : selectedPlayers;

  @override
  CreateTeamViewState createState() => CreateTeamViewState();
}

class CreateTeamViewState extends State<CreateTeamView> {
  final double checkboxHeight = 30.0;
  int teamComplete = 0;
  final double startingBudget = 100.0;
  double _budget = 100.0;
  bool _maxThreeSameTeam = true;

  @override
  void initState() {
    Map<int, int> teamCount = <int, int>{};
    for (Player player in widget.selectedPlayers) {
      _budget -= player.price;
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
    Player player = widget.selectedPlayers[index];
    Widget playerView;
    playerView = PlayerPointsCard(player: player);
    return InkWell(
        onTap: () {
        Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  AuthHelper auth =
                          Provider.of<AuthHelper>(context, listen: false);
              return PlayersCreationDetailsView(
                selectedPlayers: widget.selectedPlayers,
                playerIndex: index,
              );
            }));},
        child: Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: playerView,
        ));
  }

  showError(context, error) {
    var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          error,
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showInfo(context, info) {
    var snackBar = SnackBar(
        content: Text(
      info,
      textAlign: TextAlign.center,
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(
              title: 'Pick Team',
              navigateTo: const HomeScreen(),
              hasBackArrow: true,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: kBarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Budget: £${_budget.toStringAsFixed(1)}m",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              List.generate(2, (index) => emptyPlayer(index)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              5, (index) => emptyPlayer(index + 2)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              5, (index) => emptyPlayer(index + 7)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              3, (index) => emptyPlayer(index + 12)),
                        ),
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
            ),
            MaterialButton(
                height: 50.0,
                minWidth: double.infinity,
                splashColor: Colors.teal,
                textColor: Colors.white,
                child: const Text("Save Team", style: TextStyle(color: Colors.black),),
                onPressed: () {
                  AuthHelper auth =
                          Provider.of<AuthHelper>(context, listen: false);
                  var index = 0;
                  for (index =0; index < widget.selectedPlayers.length; index++) {
                  //   if (widget.selectedPlayers[index] == null) {
                  //     showError(context, "Please select all players");
                  //     break;
                  //   }
                if (widget.selectedPlayers[index].toJson()['team'] != 0){
                  teamComplete ++;
                }
                  }
                  
                  String message = "";
                  if (!_maxThreeSameTeam) {
                    message +=
                        "You can have at most 3 players from the same team \n";
                  }

                  if (_budget < 0) {
                    message += "You can't exceed the budget \n";
                  }
                  if (teamComplete < 15) {
                    message += "You need to select 15 players \n";
                  }
                  if (message != "") {
                    showError(context, message);
                  
                  } else {
                    setState(() {
                      AuthHelper auth =
                          Provider.of<AuthHelper>(context, listen: false);
                      auth.setSquad(widget.selectedPlayers, _budget);
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
