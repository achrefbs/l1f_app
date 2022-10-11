import 'package:fantasyapp/models/player.dart';
import 'package:fantasyapp/player_lab.dart';

class Squad {
  int squadID;
  String name;
  String owner;
  double price;
  int points;
  int pointsWeek;
  int defNum;
  int midNum;
  int fwdNum;
  final List<Player> players = [];

  Squad(
      this.squadID,
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
    players.add(playerLab.getPlayer(goalId));
    players.add(playerLab.getPlayer(player1Id));
    players.add(playerLab.getPlayer(player2Id));
    players.add(playerLab.getPlayer(player3Id));
    players.add(playerLab.getPlayer(player4Id));
    players.add(playerLab.getPlayer(player5Id));
    players.add(playerLab.getPlayer(player6Id));
    players.add(playerLab.getPlayer(player7Id));
    players.add(playerLab.getPlayer(player8Id));
    players.add(playerLab.getPlayer(player9Id));
    players.add(playerLab.getPlayer(player10Id));
    players.add(playerLab.getPlayer(subGoalId));
    players.add(playerLab.getPlayer(sub1Id));
    players.add(playerLab.getPlayer(sub2Id));
    players.add(playerLab.getPlayer(sub3Id));
    players.add(playerLab.getPlayer(sub4Id));
  }

  factory Squad.fromJson(Map<String, dynamic> json) {
    return Squad(
        json['squadID'],
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

  addPlayer(Player player) {
    players.add(player);
  }

  emptyPlayers() {
    players.clear();
  }

  //the players are from selected list are rearranged to fit the team sturcture
  // Squad.fromSelectedList({required List<PlayerB> players, required this.price})
  //     : teamId = 0,
  //       points = 0,
  //       pointsWeek = 0,
  //       defNum = 3,
  //       midNum = 4,
  //       fwdNum = 3 {
  //   _players.add(players[0]);
  //   _players.add(players[2]);
  //   _players.add(players[3]);
  //   _players.add(players[4]);
  //   _players.add(players[7]);
  //   _players.add(players[8]);
  //   _players.add(players[9]);
  //   _players.add(players[10]);
  //   _players.add(players[12]);
  //   _players.add(players[13]);
  //   _players.add(players[14]);
  //   _players.add(players[1]);
  //   _players.add(players[15]);
  //   _players.add(players[11]);
  //   _players.add(players[5]);
  //   _players.add(players[6]);
  // }

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

  String playerAt(int index) => players[index].playerID.toString();

  shiftPlayersAndInsert(delIndex, insertIndex, player) {
    players.removeAt(delIndex);
    players.insert(insertIndex, player);
  }

  int getCurrentWeeklyPoints() {
    int currentWeeklyPoints = 0;
    for (Player? player in players) {
      currentWeeklyPoints += player!.pointsWeek;
    }
    return currentWeeklyPoints;
  }

  Map<String, dynamic> toJson() => {
        'squadID': squadID,
        'name': name,
        'owner': owner,
        'price': price,
        'points': points,
        'points_week': pointsWeek,
        'def_num': defNum,
        'mid_num': midNum,
        'fwd_num': fwdNum,
        'goal': players[0].playerID,
        'player1': players[1].playerID,
        'player2': players[2].playerID,
        'player3': players[3].playerID,
        'player4': players[4].playerID,
        'player5': players[5].playerID,
        'player6': players[6].playerID,
        'player7': players[7].playerID,
        'player8': players[8].playerID,
        'player9': players[9].playerID,
        'player10': players[10].playerID,
        'sub_goal': players[11].playerID,
        'sub1': players[12].playerID,
        'sub2': players[13].playerID,
        'sub3': players[14].playerID,
        'sub4': players[15].playerID,
      };

  static empty() {
    return Squad(0, "name", "owner", 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0);
  }
}
