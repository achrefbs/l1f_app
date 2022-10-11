import 'package:fantasyapp/models/player.dart';
import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';

class PlayerPointsCard extends StatelessWidget {
  final Player player;
  const PlayerPointsCard({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image(
              image: AssetImage(player.image),
              height: kPlayerCardShirtHeight,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: kPlayerCardHeight,
              decoration: const BoxDecoration(
                color: kPlayerCardColorPrimary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Text(
                "${player.firstName.substring(0, 1)}. ${player.lastName}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kPlayerCardTextColorPrimary,
                  fontSize: kPlayerCardFontSize,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: kPlayerCardHeight,
              decoration: const BoxDecoration(
                  color: kPlayerCardColorSecondary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
              child: Text(
                "£${player.price}m",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kPlayerCardTextColorSecondary,
                  fontSize: kPlayerCardFontSize,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 5,
          right: 5,
          child: false
              //player.isCaptain
              ? Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPlayerCardCaptainColor,
                  ),
                  child: const Center(
                    child: Text(
                      "c",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
