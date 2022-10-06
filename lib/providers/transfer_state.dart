import 'package:fantasyapp/models/player.dart';
import 'package:flutter/cupertino.dart';

class TransferState extends ChangeNotifier {
  var selectedGKs = [
    Player(name: "-", id: "id", teamId: "teamId", position: Pos.gk),
    Player(name: "-", id: "id", teamId: "teamId", position: Pos.gk)
  ];
}
