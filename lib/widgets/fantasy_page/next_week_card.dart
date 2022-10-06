import 'package:fantasyapp/providers/game_state_helper.dart';
import 'package:fantasyapp/widgets/border_card.dart';
import 'package:flutter/cupertino.dart';

class NextWeekCard extends StatelessWidget {
  final GameStateHelper gameState;
  const NextWeekCard({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return BorderCard(
      height: 200,
      widget: Column(children: [
        Text(
            "Game Week: ${gameState.getCurrentGameState().currentGameWeek + 1}"),
      ]),
    );
  }
}
