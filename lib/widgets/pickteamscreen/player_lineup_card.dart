import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';

class PlayerLineupCard extends StatelessWidget {
  final String name;
  final String shirt;
  final String nextMatch;
  final bool isCaptain;
  const PlayerLineupCard({
    Key? key,
    required this.name,
    required this.shirt,
    required this.nextMatch,
    this.isCaptain = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Image(
              image: AssetImage(shirt),
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
                name,
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
                nextMatch,
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
          child: isCaptain
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
