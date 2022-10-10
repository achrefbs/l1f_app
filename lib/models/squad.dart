import 'package:fantasyapp/playerB.dart';
import 'package:fantasyapp/player_lab.dart';

class Squad {
  int teamId;
  String name;
  String owner;
  double price;
  int points;
  int pointsWeek;
  int defNum;
  int midNum;
  int fwdNum;
  final List<PlayerB> _players = [];

  Squad(
      this.teamId,
      this.name,
      this.owner,
      this.price,
      this.points,
      this.pointsWeek,
      this.defNum,
      this.midNum,
      this.fwdNum,
      int goalId,
      int player1Id,
      int player2Id,
      int player3Id,
      int player4Id,
      int player5Id,
      int player6Id,
      int player7Id,
      int player8Id,
      int player9Id,
      int player10Id,
      int subGoalId,
      int sub1Id,
      int sub2Id,
      int sub3Id,
      int sub4Id) {
    PlayerLab playerLab = PlayerLab.get();
    _players.add(playerLab.getPlayer(goalId));
    _players.add(playerLab.getPlayer(player1Id));
    _players.add(playerLab.getPlayer(player2Id));
    _players.add(playerLab.getPlayer(player3Id));
    _players.add(playerLab.getPlayer(player4Id));
    _players.add(playerLab.getPlayer(player5Id));
    _players.add(playerLab.getPlayer(player6Id));
    _players.add(playerLab.getPlayer(player7Id));
    _players.add(playerLab.getPlayer(player8Id));
    _players.add(playerLab.getPlayer(player9Id));
    _players.add(playerLab.getPlayer(player10Id));
    _players.add(playerLab.getPlayer(subGoalId));
    _players.add(playerLab.getPlayer(sub1Id));
    _players.add(playerLab.getPlayer(sub2Id));
    _players.add(playerLab.getPlayer(sub3Id));
    _players.add(playerLab.getPlayer(sub4Id));
  }

  factory Squad.fromJson(Map<String, dynamic> json) {
    return Squad(
        json['teamId'],
        json['name'],
        json['owner'],
        json['price'],
        json['points'],
        json['pointsWeek'],
        json['defNum'],
        json['midNum'],
        json['fwdNum'],
        json['goalId'],
        json['player1Id'],
        json['player2Id'],
        json['player3Id'],
        json['player4Id'],
        json['player5Id'],
        json['player6Id'],
        json['player7Id'],
        json['player8Id'],
        json['player9Id'],
        json['player10Id'],
        json['subGoalId'],
        json['sub1Id'],
        json['sub2Id'],
        json['sub3Id'],
        json['sub4Id']);
  }

  //the players are from selected list are rearranged to fit the team sturcture
  Squad.fromSelectedList(
      {required List<PlayerB> players,
      required this.name,
      required this.owner,
      required this.price})
      : teamId = 0,
        points = 0,
        pointsWeek = 0,
        defNum = 3,
        midNum = 4,
        fwdNum = 3 {
    _players.add(players[0]);
    _players.add(players[2]);
    _players.add(players[3]);
    _players.add(players[4]);
    _players.add(players[7]);
    _players.add(players[8]);
    _players.add(players[9]);
    _players.add(players[10]);
    _players.add(players[12]);
    _players.add(players[13]);
    _players.add(players[14]);
    _players.add(players[1]);
    _players.add(players[15]);
    _players.add(players[11]);
    _players.add(players[5]);
    _players.add(players[6]);
  }

  factory Squad.fromTeamsJson(Map<String, dynamic> json) {
    return Squad(
        int.parse(json['team_id']),
        json['name'],
        json['owner'],
        double.parse(json['price']),
        int.parse(json['points']),
        int.parse(json['points_week']),
        int.parse(json['def_num']),
        int.parse(json['mid_num']),
        int.parse(json['fwd_num']),
        int.parse(json['goal']),
        int.parse(json['player1']),
        int.parse(json['player2']),
        int.parse(json['player3']),
        int.parse(json['player4']),
        int.parse(json['player5']),
        int.parse(json['player6']),
        int.parse(json['player7']),
        int.parse(json['player8']),
        int.parse(json['player9']),
        int.parse(json['player10']),
        int.parse(json['sub_goal']),
        int.parse(json['sub1']),
        int.parse(json['sub2']),
        int.parse(json['sub3']),
        int.parse(json['sub4']));
  }

  String playerAt(int index) => players[index]!.playerID.toString();

  List<PlayerB?> get players => _players;

  shiftPlayersAndInsert(delIndex, insertIndex, player) {
    _players.removeAt(delIndex);
    _players.insert(insertIndex, player);
  }

  int getCurrentWeeklyPoints() {
    int currentWeeklyPoints = 0;
    for (PlayerB? player in players) {
      currentWeeklyPoints += player!.pointsWeek;
    }
    return currentWeeklyPoints;
  }

  Map<String, dynamic> toJson() => {
        'team_id': teamId,
        'name': name,
        'owner': owner,
        'price': price,
        'points': points,
        'points_week': pointsWeek,
        'def_num': defNum,
        'mid_num': midNum,
        'fwd_num': fwdNum,
        'goal': _players[0].playerID,
        'player1': _players[1].playerID,
        'player2': _players[2].playerID,
        'player3': _players[3].playerID,
        'player4': _players[4].playerID,
        'player5': _players[5].playerID,
        'player6': _players[6].playerID,
        'player7': _players[7].playerID,
        'player8': _players[8].playerID,
        'player9': _players[9].playerID,
        'player10': _players[10].playerID,
        'sub_goal': _players[11].playerID,
        'sub1': _players[12].playerID,
        'sub2': _players[13].playerID,
        'sub3': _players[14].playerID,
        'sub4': _players[15].playerID,
      };

  static empty() {
    return Squad(0, "name", "owner", 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0);
  }
}
