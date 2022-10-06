import 'package:fantasyapp/models/player.dart';
import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';

class PlayerTransferCard extends StatelessWidget {
  final Player player;
  const PlayerTransferCard({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const Image(
              image: AssetImage("images/est-shirt.png"),
              height: kPlayerCardShirtHeight,
            ),
            Container(
              width: kPlayerCardWidth,
              height: kPlayerCardHeight,
              decoration: const BoxDecoration(
                color: kPlayerCardColorPrimary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Text(
                player.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kPlayerCardTextColorPrimary,
                  fontSize: kPlayerCardFontSize,
                ),
              ),
            ),
            Container(
              width: kPlayerCardWidth,
              height: kPlayerCardHeight,
              decoration: const BoxDecoration(
                  color: kPlayerCardColorSecondary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
              child: Text(
                player.price.toString(),
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
          child: false //player.isCaptain
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
