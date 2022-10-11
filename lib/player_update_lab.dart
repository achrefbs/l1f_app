
// class PlayerUpdateLab {
//   bool _cleanSheet = false;
//   late int team;
//   late int score;
//   late int opponentScore;
//   late String opponent;
//   late String username;
//   late int userId;
//   late Map<int, PlayerUpdate> players;

//   PlayerUpdateLab() {
//     TeamStats ts = TeamStats.get()!;
//     Manager user = Manager.get();
//     _cleanSheet = ts.cleanSheet;
//     team = ts.team;
//     opponentScore = ts.opponentScore;
//     score = ts.ICScore;
//     opponent = ts.opponent;
//     username = user.username;
//     userId = user.userId;

//     for (PlayerB p in ts.getSelectedPlayers(Stat.appearances)) {
//       players[p.playerID] = (PlayerUpdate(p.playerID, false, p.position));
//     }
//     for (PlayerB p in ts.getSelectedPlayers(Stat.subs)) {
//       players[p.playerID] = (PlayerUpdate(p.playerID, true, p.position));
//     }
//     for (PlayerB p in ts.getSelectedPlayers(Stat.motm)) {
//       players[p.playerID]!.motms = 1;
//     }
//     for (PlayerB p in ts.getSelectedPlayers(Stat.goals)) {
//       players[p.playerID]!.goals += 1;
//     }
//     for (PlayerB p in ts.getSelectedPlayers(Stat.assists)) {
//       players[p.playerID]!.assists += 1;
//     }
//     for (PlayerB p in ts.getSelectedPlayers(Stat.ownGoals)) {
//       players[p.playerID]!.ownGoals += 1;
//     }
//     for (PlayerB p in ts.getSelectedPlayers(Stat.redCards)) {
//       players[p.playerID]!.redCards += 1;
//     }
//     for (PlayerB p in ts.getSelectedPlayers(Stat.yellowCards)) {
//       players[p.playerID]!.yellowCards += 1;
//     }
//   }

//   List<PlayerUpdate> get playerUpdates => players.values.toList();

//   bool get cleanSheet => _cleanSheet;

//   Map<String, dynamic> toJson() => {
//         'cleanSheet': _cleanSheet,
//         'team': team,
//         'ICScore': score,
//         'opponentScore': opponentScore,
//         'opponent': opponent,
//         'username': username,
//         'userId': userId,
//         'players': players.values.toList()
//       };
// }
