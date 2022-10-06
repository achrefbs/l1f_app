enum Pos {
  gk,
  def,
  mid,
  att,
}

class Player {
  String id;
  String name;
  double price;
  int age;
  String birthDay;
  String natinality;
  double height;
  double weight;
  bool injured;
  String photo;
  String teamId;
  int appearences;
  int firstTeam;
  int minutes;
  Pos position;
  int goals;
  int yellowCards;
  int yellowRedCards;
  int redCards;

  Map<String, String> points;

  Player({
    required this.name,
    required this.id,
    this.price = 5.0,
    this.age = 23,
    this.birthDay = '07/06/1999',
    this.natinality = 'Tunisienne',
    this.height = 1.75,
    this.weight = 65.5,
    this.injured = false,
    this.photo = "",
    required this.teamId,
    this.appearences = 0,
    this.firstTeam = 0,
    this.minutes = 0,
    required this.position,
    this.goals = 69,
    this.yellowCards = 0,
    this.yellowRedCards = 0,
    this.redCards = 0,
    this.points = const {
      "0": "0",
      "1": "10",
      "2": "8",
      "3": "6",
      "4": "4",
      "5": "2",
      "6": "1",
    },
  });

  Player.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        age = json['age'],
        birthDay = json['birth_day'],
        natinality = json['natinality'],
        height = json['height'],
        weight = json['weight'],
        injured = json['injured'],
        photo = json['photo'],
        teamId = json['team_id'],
        appearences = json['appearences'],
        firstTeam = json['first_team'],
        minutes = json['minutes'],
        position = Pos.values[json['position']],
        goals = json['goals'],
        yellowCards = json['yellow_cards'],
        yellowRedCards = json['yellow_red_cards'],
        redCards = json['red_cards'],
        points = json['points'],
        price = json['price'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'birthDay': birthDay,
      'natinality': natinality,
      'height': height,
      'weight': weight,
      'injured': injured,
      'photo': photo,
      'teamId': teamId,
      'appearences': appearences,
      'firstTeam': firstTeam,
      'minutes': minutes,
      'position': position.index,
      'goals': goals,
      'yellowCards': yellowCards,
      'yellowRedCards': yellowRedCards,
      'redCards': redCards,
      'points': points,
      'price': price,
    };
  }
}
