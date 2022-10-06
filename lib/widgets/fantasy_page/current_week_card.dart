import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/providers/game_state_helper.dart';
import 'package:fantasyapp/screens/team_history_screen.dart';
import 'package:fantasyapp/widgets/border_card.dart';
import 'package:flutter/material.dart';

class CurrentWeekCard extends StatelessWidget {
  const CurrentWeekCard({
    Key? key,
    required this.gameState,
    required this.manager,
    required this.auth,
  }) : super(key: key);

  final GameStateHelper gameState;
  final Manager manager;
  final AuthHelper auth;

  @override
  Widget build(BuildContext context) {
    return BorderCard(
      height: 200,
      widget: Column(children: [
        Text("Game Week: ${gameState.getCurrentGameState().currentGameWeek}"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TeamHistoryScreen(
                    manager: manager,
                  ),
                ),
              ),
              child: Text("Points: ${auth.current!.currentWeekPoints}"),
            ),
            FutureBuilder(
                future: gameState.getHighestPointsManager(),
                builder: (context, AsyncSnapshot<Manager> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("something went wrong!");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text("Highest: ${snapshot.data!.currentWeekPoints}");
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ]),
    );
  }
}
