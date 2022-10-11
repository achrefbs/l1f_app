import 'package:fantasyapp/models/player.dart';

class PlayerLab {
  final List<Player> players = [];
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
