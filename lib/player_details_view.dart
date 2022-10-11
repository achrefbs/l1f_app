import 'package:fantasyapp/models/player.dart';
import 'package:flutter/material.dart';

class PlayerDetailsView extends StatelessWidget {
  final Player _p;

  const PlayerDetailsView(this._p, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_p.fullName),
      ),
      body: Column(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    _p.fullName,
                    style: const TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                  Text(
                    '${_p.position} in the ${_p.teamAsString} team',
                    style: const TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                ],
              )),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              _p.image,
              height: 200.0,
            ),
            Column(
              children: <Widget>[
                getStatText('Points', _p.points.toString()),
                getStatText('Points This Week', _p.pointsWeek.toString()),
                getStatText('Apps', _p.appearances.toString()),
                getStatText('Sub Apps', _p.subAppearances.toString()),
                getStatText('Goals', _p.goals.toString()),
                getStatText('Assists', _p.assists.toString()),
                getStatText('MOTMs', _p.motms.toString()),
                getStatText('CSs', _p.cleanSheets.toString()),
                getStatText('Yellow Cards', _p.yellowCards.toString()),
                getStatText('Red Cards', _p.redCards.toString()),
                getStatText('Own Goals', _p.ownGoals.toString()),
              ],
            )
          ],
        ),
      ]),
    );
  }

  Widget getStatText(String text, String stat) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
        ),
        children: <TextSpan>[
          TextSpan(
              text: '$text: ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: stat),
        ],
      ),
    );
  }
}
