import 'package:fantasyapp/models/squad.dart';
import 'package:fantasyapp/playerB.dart';
import 'package:fantasyapp/player_details_view.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatefulWidget {
  final Function updateState;
  final PlayerB player;
  final int index;

  const PlayerView(
      {Key? key,
      required this.updateState,
      required this.player,
      required this.index})
      : super(key: key);

  @override
  PlayerViewState createState() => PlayerViewState();
}

class PlayerViewState extends State<PlayerView> {
  late Squad team;

  @override
  void initState() {
    AuthHelper auth = Provider.of<AuthHelper>(context, listen: false);
    super.initState();
    team = auth.current!.squad;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return PlayerDetailsView(widget.player);
            }));
          },
          child: DragTarget<List<dynamic>>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              final hovered = accepted.isNotEmpty;
              return Container(
                  color: hovered ? Colors.green : const Color(0x00000000),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          widget.player.image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        child: Text(
                          "${widget.player.firstName.substring(0, 1)}. ${widget.player.lastName}",
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        child: Text(
                            "${widget.player.points}|${widget.player.pointsWeek}",
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ));
            },
            onWillAccept: (value) {
              if (value![0].position == widget.player.position) return true;
              switch (widget.player.position) {
                case "GK":
                  {
                    return false;
                  }
                case "DEF":
                  {
                    if (team.defNum <= 3) return false;
                  }
                  break;

                case "MID":
                  {
                    if (team.midNum <= 3) return false;
                  }
                  break;

                case "FWD":
                  {
                    if (team.fwdNum <= 2) return false;
                  }
                  break;
              }
              switch (value[0].position) {
                case "GK":
                  {
                    return false;
                  }
                case "DEF":
                  {
                    if (team.defNum >= 5) return false;
                  }
                  break;

                case "MID":
                  {
                    if (team.midNum >= 5) return false;
                  }
                  break;

                case "FWD":
                  {
                    if (team.fwdNum >= 3) return false;
                  }
                  break;
              }
              return true;
            },
            onAccept: (value) {
              int insert = 0;
              //handles repositioning of players
              if (value[0].position != widget.player.position) {
                switch (value[0].position) {
                  case "DEF":
                    insert = team.defNum;
                    team.defNum++;
                    break;
                  case "MID":
                    insert = team.defNum + team.midNum;
                    team.midNum++;
                    break;
                  case "FWD":
                    insert = 10;
                    team.fwdNum++;
                    break;
                }
                switch (widget.player.position) {
                  case "DEF":
                    team.defNum--;
                    break;
                  case "MID":
                    team.midNum--;
                    break;
                  case "FWD":
                    team.fwdNum--;
                    break;
                }
                team.shiftPlayersAndInsert(widget.index, insert, value[0]);
              } else {
                team.players[widget.index] = value[0];
              }
              team.players[value[1]] = widget.player;

              //need to redraw all effected elements
              widget.updateState();
            },
          ),
        ));
  }
}
