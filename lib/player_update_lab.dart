import 'package:fantasyapp/playerB.dart';
import 'package:fantasyapp/player_update.dart';
import 'package:fantasyapp/team_stats.dart';
import 'package:fantasyapp/user.dart';

class PlayerUpdateLab {
  bool _cleanSheet = false;
  late int _team;
  late int _ICScore;
  late int _opponentScore;
  late String _opponent;
  late String _username;
  late int _userId;
  late Map<int, PlayerUpdate> _players;

  PlayerUpdateLab() {
    TeamStats ts = TeamStats.get()!;
    UserB user = UserB.get();
    //override clean sheets
    _cleanSheet = ts.cleanSheet;
    _team = ts.team;
    _opponentScore = ts.opponentScore;
    _ICScore = ts.ICScore;
    _opponent = ts.opponent;
    _username = user.username;
    _userId = user.userId;

    for (PlayerB p in ts.getSelectedPlayers(Stat.appearances)) {
      _players[p.playerID] = (PlayerUpdate(p.playerID, false, p.position));
    }
    for (PlayerB p in ts.getSelectedPlayers(Stat.subs)) {
      _players[p.playerID] = (PlayerUpdate(p.playerID, true, p.position));
    }
    for (PlayerB p in ts.getSelectedPlayers(Stat.motm)) {
      _players[p.playerID]!.motms = 1;
    }
    for (PlayerB p in ts.getSelectedPlayers(Stat.goals)) {
      _players[p.playerID]!.goals += 1;
    }
    for (PlayerB p in ts.getSelectedPlayers(Stat.assists)) {
      _players[p.playerID]!.assists += 1;
    }
    for (PlayerB p in ts.getSelectedPlayers(Stat.ownGoals)) {
      _players[p.playerID]!.ownGoals += 1;
    }
    for (PlayerB p in ts.getSelectedPlayers(Stat.redCards)) {
      _players[p.playerID]!.redCards += 1;
    }
    for (PlayerB p in ts.getSelectedPlayers(Stat.yellowCards)) {
      _players[p.playerID]!.yellowCards += 1;
    }
  }

  List<PlayerUpdate> get playerUpdates => _players.values.toList();

  bool get cleanSheet => _cleanSheet;

  int get team => _team;

  Map<String, dynamic> toJson() => {
        'cleanSheet': _cleanSheet,
        'team': _team,
        'ICScore': _ICScore,
        'opponentScore': _opponentScore,
        'opponent': _opponent,
        'username': _username,
        'userId': _userId,
        'players': _players.values.toList()
      };

  int get ICScore => _ICScore;

  int get opponentScore => _opponentScore;

  String get opponent => _opponent;

  int get userId => _userId;

  String get username => _username;
}
