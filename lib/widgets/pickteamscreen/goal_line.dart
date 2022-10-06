import 'package:fantasyapp/widgets/pickteamscreen/player_lineup_card.dart';
import 'package:flutter/material.dart';

class GoadLine extends StatelessWidget {
  GoadLine({Key? key, required this.playerID}) : super(key: key);
  //Player player;
  String playerID;

  @override
  Widget build(BuildContext context) {
    return const PlayerLineupCard(
      name: 'M. Debchi',
      shirt: 'images/est-shirt-g-short.png',
      nextMatch: 'CSS (H)',
    );
  }
}
