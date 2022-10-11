import 'package:fantasyapp/models/player.dart';

class PlayerLab {
  final List<Player> players = [
    Player(0, "firstName", "lastName", "GK", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(1, "firstName", "lastName", "GK", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(2, "firstName", "lastName", "GK", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(3, "firstName", "lastName", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(4, "firstName", "lastName", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(5, "firstName", "lastName", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(6, "firstName", "lastName", "MID", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(7, "firstName", "lastName", "MID", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(8, "firstName", "lastName", "MID", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(9, "firstName", "lastName", "FWD", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0),
    Player(10, "firstName", "lastName", "FWD", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(11, "firstName", "lastName", "FWD", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(12, "firstName", "lastName", "FWD", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(13, "firstName", "lastName", "FWD", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(14, "firstName", "lastName", "MID", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(15, "firstName", "lastName", "MID", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(16, "firstName", "lastName", "MID", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(17, "firstName", "lastName", "MID", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(18, "firstName", "lastName", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(19, "firstName", "lastName", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
    Player(20, "firstName", "lastName", "DEF", 1, 5.5, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0),
  ];
  static PlayerLab sPlayerLab = PlayerLab();

  static PlayerLab get() {
    return sPlayerLab;
  }

  void addPlayer(Player player) {
    sPlayerLab.players.add(player);
  }

  Player getPlayer(int id) {
    for (Player player in players) {
      if (player.playerID == id) {
        return player;
      }
    }
    return Player.empty();
  }

  PlayerLab();

  PlayerLab.fromJson(List<dynamic> json) {
    sPlayerLab = PlayerLab();
    for (Map<String, dynamic> playerJson in json) {
      addPlayer(Player.fromJson(playerJson));
    }
  }
}
