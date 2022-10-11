import 'package:fantasyapp/playerB.dart';
import 'package:fantasyapp/player_lab.dart';

enum Stat {
  appearances,
  subs,
  motm,
  yellowCards,
  redCards,
  goals,
  assists,
  ownGoals
}

class TeamStats {
  int team = 1;
  String opponent = "";
  int ICScore = 0;
  int opponentScore = 0;
  List<PlayerB> _appAvailablePlayers = List.from(PlayerLab.get().players);
  List<PlayerB> _subAvailablePlayers = List.from(PlayerLab.get().players);
  List<List<PlayerB>> _currentStats =
      List.generate(Stat.ownGoals.index + 1, (int index) => []);
  static TeamStats? _teamStats;

  static TeamStats? get() {
    _teamStats ??= TeamStats();
    return _teamStats;
  }

  //(players for the rest selection can be selected as union of index 0 and 1 in _currentStats
  List<PlayerB> getAvailablePlayers(Stat stat) {
    if (stat == Stat.appearances) {
      return _appAvailablePlayers;
    }
    if (stat == Stat.subs) {
      return _subAvailablePlayers;
    }

    return _currentStats[0] + _currentStats[1];
  }

  List<PlayerB> getSelectedPlayers(Stat stat) {
    return _currentStats[stat.index];
  }

  bool isPlayerSelected(PlayerB player, Stat stat) {
    return _currentStats[stat.index].contains(player);
  }

  int getStatCount(Stat stat) {
    return _currentStats[stat.index].length;
  }

  int getStatPlayerCount(PlayerB player, Stat stat) {
    return _currentStats[stat.index].where((PlayerB p) => p == player).length;
  }

  //remove appearance players from subs list
  setSubSelection() {
    _currentStats[Stat.subs.index] = [];
    _subAvailablePlayers = List.from(PlayerLab.get().players);
    for (PlayerB player in _currentStats[0]) {
      _subAvailablePlayers.remove(player);
    }
  }

  addPlayer(PlayerB player, Stat stat) {
    _currentStats[stat.index].add(player);
  }

  removePlayer(PlayerB player, Stat stat) {
    _currentStats[stat.index].remove(player);
  }

  Stat nextStat(Stat stat) {
    return Stat.values[stat.index + 1];
  }

  //all stats including goals and after are buttoned
  bool isNextStatButtoned(Stat stat) {
    return nextStat(stat).index >= Stat.goals.index;
  }

  bool isFinalButton(Stat stat) {
    return stat.index == Stat.ownGoals.index;
  }

  String statAsString(Stat stat) {
    switch (stat) {
      case Stat.appearances:
        return "Starting players";
      case Stat.subs:
        return "Subs";
      case Stat.motm:
        return "MOTM";
      case Stat.goals:
        return "Goals";
      case Stat.assists:
        return "Assists";
      case Stat.ownGoals:
        return "Own Goals";
      case Stat.yellowCards:
        return "Yellow Cards";
      case Stat.redCards:
        return "Red Cards";
    }
  }

  void resetAll() {
    _currentStats = List.generate(Stat.ownGoals.index + 1, (int index) => []);
    _appAvailablePlayers = List.from(PlayerLab.get().players);
  }

  bool get cleanSheet => opponentScore == 0;

  static set teamStats(TeamStats value) {
    _teamStats = value;
  }
}
