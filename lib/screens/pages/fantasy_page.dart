import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/providers/game_state_helper.dart';
import 'package:fantasyapp/screens/setup_team_screen.dart';
import 'package:fantasyapp/widgets/border_card.dart';
import 'package:fantasyapp/widgets/fantasy_page/current_week_card.dart';
import 'package:fantasyapp/widgets/fantasy_page/next_week_card.dart';
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
          height: 100,
          widget: Text(manager.username),
        ),
        manager.initializedTeam == false
            ? Column(
                children: [
                  const Text("You have not initialized your team yet!"),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => const SetupTeamScreen()),
                      ),
                    ),
                    child: const Text("Select Team"),
                  ),
                ],
              )
            : Column(
                children: [
                  CurrentWeekCard(
                    gameState: gameState,
                    manager: manager,
                    auth: auth,
                  ),
                  NextWeekCard(
                    gameState: gameState,
                  ),
                ],
              ),
      ],
    );
  }
}
