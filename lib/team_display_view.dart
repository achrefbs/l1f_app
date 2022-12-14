import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/models/squad.dart';
import 'package:fantasyapp/player_lab.dart';
import 'package:fantasyapp/player_view.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/sub_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamDisplayView extends StatefulWidget {
  const TeamDisplayView({super.key});

  @override
  TeamDisplayViewState createState() => TeamDisplayViewState();
}

class TeamDisplayViewState extends State<TeamDisplayView> {
  PlayerLab playerLab = PlayerLab.get();
  Widget saveChanges = const Text("Press to save changes");

  @override
  Widget build(BuildContext context) {
    AuthHelper auth = Provider.of<AuthHelper>(context);
    Squad team = auth.currentSquad!;
    updateState() {
      setState(() {
        team = auth.currentSquad!;
      });
    }

    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          //   color: Colors.lightBlue,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       Expanded(
          //         flex: 1,
          //         child: Text("Points ${team.points}"),
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: Text(
          //           "This week ${team.getCurrentWeeklyPoints()}",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
              child: Stack(children: <Widget>[
            Positioned.fill(
                child: Image.asset(
              "assets/pitch.jpg",
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft,
            )),
            Positioned.fill(
                child: Image.asset(
              "assets/bench.jpg",
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
            )),
          ])),
          MaterialButton(
              height: 50.0,
              minWidth: double.infinity,
              color: Colors.blueAccent,
              splashColor: Colors.teal,
              textColor: Colors.white,
              child: saveChanges,
              onPressed: () {
                setState(() {
                  saveChanges = FutureBuilder(
                    future: auth.updateSquad(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Text("Press to save changes");
                      }
                      // By default, show a loading spinner
                      return const CircularProgressIndicator();
                    },
                  );
                });
              }),
        ],
      ),
      Column(
        //players
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 4, child: Container()),
          Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    1,
                    (index) => PlayerView(
                          player: team.players[0],
                          index: 0,
                          updateState: updateState,
                        )),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    team.defNum,
                    (index) => PlayerView(
                        player: team.players[index + 1],
                        index: index + 1,
                        updateState: updateState)),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    team.midNum,
                    (index) => PlayerView(
                        player: team.players[index + team.defNum + 1],
                        index: index + team.defNum + 1,
                        updateState: updateState)),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    team.fwdNum,
                    (index) => PlayerView(
                        player:
                            team.players[index + team.defNum + team.midNum + 1],
                        index: index + team.defNum + team.midNum + 1,
                        updateState: updateState)),
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    4,
                    (index) => SubView(
                        player: team.players[11 + index], index: 11 + index)),
              )),
          Expanded(flex: 5, child: Container()),
        ],
      )
    ]));
  }
}
