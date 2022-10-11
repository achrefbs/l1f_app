import 'package:fantasyapp/playerB.dart';

class PlayerLab {
  final List<PlayerB> _players = [
    PlayerB(1, "David", "de Gea", "GK", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        false),
    PlayerB(2, "Sergio", "Romero", "GK", 1, 4.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, false),
    PlayerB(3, "Lee", "Grant", "GK", 1, 4.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        false),
    PlayerB(4, "Victor", "Lindelof", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, false),
    PlayerB(5, "Eric", "Bailly", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        false),
    PlayerB(6, "Marcos", "Rojo", "DEF", 1, 5.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        false),
    PlayerB(7, "Phil", "Jones", "DEF", 1, 5.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        false),
  ];
  static PlayerLab sPlayerLab = PlayerLab();

  static PlayerLab get() {
    return sPlayerLab;
  }

  void addPlayer(PlayerB player) {
    sPlayerLab.players.add(player);
  }

  PlayerB getPlayer(int id) {
    for (PlayerB player in _players) {
      if (player.playerID == id) {
        return player;
      }
    }
    return PlayerB.empty();
  }

  PlayerLab();

  PlayerLab.fromJson(List<dynamic> json) {
    sPlayerLab = PlayerLab();
    for (Map<String, dynamic> playerJson in json) {
      addPlayer(PlayerB.fromJson(playerJson));
    }
  }

  List<PlayerB> get players => _players;
}
