import 'package:fantasyapp/widgets/pickteamscreen/player_lineup_card.dart';
import 'package:flutter/material.dart';

class AttackLine extends StatelessWidget {
  const AttackLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        PlayerLineupCard(
          name: 'Y. Abdelli',
          shirt: 'images/usm-shirt.png',
          nextMatch: 'OB (A)',
        ),
        PlayerLineupCard(
          name: 'T. Meziani',
          shirt: 'images/ess-shirt.png',
          nextMatch: 'UST (H)',
        ),
      ],
    );
  }
}
