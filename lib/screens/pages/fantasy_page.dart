import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/providers/game_state_helper.dart';
import 'package:fantasyapp/screens/team_history_screen.dart';
import 'package:fantasyapp/widgets/border_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FantasyPage extends StatefulWidget {
  const FantasyPage({super.key});

  @override
  State<FantasyPage> createState() => _FantasyPageState();
}

class _FantasyPageState extends State<FantasyPage> {
  @override
  Widget build(BuildContext context) {
    AuthHelper auth = Provider.of<AuthHelper>(context);
    GameStateHelper gameState = Provider.of<GameStateHelper>(context);

    Manager manager = auth.current!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BorderCard(
          flex: 1,
          widget: Text(manager.username),
        ),
        BorderCard(
          flex: 6,
          widget: Column(children: [
            Text(
                "Game Week: ${gameState.getCurrentGameState().currentGameWeek}"),
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
                        return Text(
                            "Highest: ${snapshot.data!.currentWeekPoints}");
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
