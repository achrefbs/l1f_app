import 'package:fantasyapp/widgets/pickteamscreen/player_lineup_card.dart';
import 'package:flutter/material.dart';

class DefenceLine extends StatelessWidget {
  const DefenceLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        PlayerLineupCard(
          name: 'A. Bouazra',
          shirt: 'images/ess-shirt.png',
          nextMatch: 'UST (H)',
        ),
        PlayerLineupCard(
          name: 'H. Dagdoug',
          shirt: 'images/css-shirt.png',
          nextMatch: 'EST (A)',
        ),
        PlayerLineupCard(
          name: 'N. Ghandri',
          shirt: 'images/ca-shirt.png',
          nextMatch: '-',
        ),
        PlayerLineupCard(
          name: 'S. Labidi',
          shirt: 'images/ca-shirt.png',
          nextMatch: '-',
        ),
      ],
    );
  }
}
