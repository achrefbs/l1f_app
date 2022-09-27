import 'package:fantasyapp/widgets/pickteamscreen/player_lineup_card.dart';
import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';

class SubstituteLine extends StatelessWidget {
  const SubstituteLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 137,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(
        color: kTransparentBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          PlayerLineupCard(
            name: 'A. Ejjemel',
            shirt: 'images/ess-shirt-g-short.png',
            nextMatch: 'UST (H)',
          ),
          PlayerLineupCard(
            name: 'M. Sola',
            shirt: 'images/css-shirt.png',
            nextMatch: 'EST (A)',
          ),
          PlayerLineupCard(
            name: 'A. Garreb',
            shirt: 'images/ca-shirt.png',
            nextMatch: '-',
          ),
          PlayerLineupCard(
            name: 'Iheb M\'barki',
            shirt: 'images/usm-shirt.png',
            nextMatch: 'OB (A)',
          ),
        ],
      ),
    );
  }
}
