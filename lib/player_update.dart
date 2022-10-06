// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)

class PlayerUpdate {
  final int _playerID;
  int appearances = 0;
  int subAppearances = 0;
  int goals = 0;
  int assists = 0;
  int cleanSheets = 0;
  int motms = 0;
  int ownGoals = 0;
  int redCards = 0;
  int yellowCards = 0;
  late String position;

  PlayerUpdate(this._playerID, bool isSub, this.position) {
    if (isSub) {
      subAppearances = 1;
    } else {
      appearances = 1;
    }
  }

  int get playerID => _playerID;

  Map<String, dynamic> toJson() => {
        'player_id': playerID,
        'appearances': appearances,
        'sub_appearances': subAppearances,
        'goals': goals,
        'assists': assists,
        'clean_sheets': cleanSheets,
        'motms': motms,
        'own_goals': ownGoals,
        'red_cards': redCards,
        'yellow_cards': yellowCards,
        'position': position
      };
}
