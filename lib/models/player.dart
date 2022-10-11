class Player {
  late int playerID;
  late String firstName;
  late String lastName;
  late String position;
  late int team;
  late double price;
  int points = 0;
  int pointsWeek = 0;
  int appearances = 0;
  int subAppearances = 0;
  int goals = 0;
  int assists = 0;
  int cleanSheets = 0;
  int motms = 0;
  int ownGoals = 0;
  int redCards = 0;
  int yellowCards = 0;
  late String image;

  Player(
    this.playerID,
    this.firstName,
    this.lastName,
    this.position,
    this.team,
    this.price,
    this.points,
    this.pointsWeek,
    this.appearances,
    this.subAppearances,
    this.goals,
    this.assists,
    this.cleanSheets,
    this.motms,
    this.ownGoals,
    this.redCards,
    this.yellowCards,
  ) {
    if (position == ("GK")) {
      image = "assets/goal.png";
    } else {
      image = "assets/shirt$team.png";
    }
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      int.parse(json['player_id']),
      json['first_name'],
      json['last_name'],
      json['position'],
      int.parse(json['team']),
      double.parse(json['price']),
      int.parse(json['points']),
      int.parse(json['points_week']),
      int.parse(json['appearances']),
      int.parse(json['sub_appearances']),
      int.parse(json['goals']),
      int.parse(json['assists']),
      int.parse(json['clean_sheets']),
      int.parse(json['motms']),
      int.parse(json['own_goals']),
      int.parse(json['red_cards']),
      int.parse(json['yellow_cards']),
    );
  }

  Player.empty() {
    price = 0.0;
    image = "assets/shirt_blank.png";
    firstName = "first";
    lastName = "last";
    position = "position";
    team = 0;
    playerID = 0;
  }

  String get teamAsString {
    String suffix;
    switch (team) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
    return team.toString() + suffix;
  }

  String get fullName => "$firstName $lastName";
  Map<String, Object> toJson() {
    return {
      'player_id': playerID,
      'first_name': firstName,
      'last_name': lastName,
      'position': position,
      'team': team,
      'price': price,
      'points': points,
      'points_week': pointsWeek,
      'appearances': appearances,
      'sub_appearances': subAppearances,
      'goals': goals,
      'assists': assists,
      'clean_sheets': cleanSheets,
      'motms': motms,
      'own_goals': ownGoals,
      'red_cards': redCards,
      'yellow_cards': yellowCards,
    };
  }
}
