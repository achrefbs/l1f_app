import 'package:fantasyapp/widgets/pickteamscreen/player_lineup_card.dart';
import 'package:flutter/material.dart';

class MidLine extends StatelessWidget {
  const MidLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        PlayerLineupCard(
          name: 'M. Ben Romdhane',
          shirt: 'images/est-shirt.png',
          nextMatch: 'CSS (H)',
        ),
        PlayerLineupCard(
          name: 'G. Chalali',
          shirt: 'images/est-shirt.png',
          nextMatch: 'CSS (H)',
          isCaptain: true,
        ),
        PlayerLineupCard(
          name: 'A. Harzi',
          shirt: 'images/css-shirt.png',
          nextMatch: 'EST (A)',
        ),
        PlayerLineupCard(
          name: 'I. Mhirsi',
          shirt: 'images/usm-shirt.png',
          nextMatch: 'OB (A)',
        ),
      ],
    );
  }
}
