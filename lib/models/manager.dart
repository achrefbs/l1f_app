import 'package:fantasyapp/models/squad.dart';

const Map<String, int> pointsHistoryE = {
  "w0": 0,
  "w1": 0,
  "w2": 0,
  "w3": 0,
  "w4": 0
};

const Map<String, Map<String, dynamic>> squadHistoryE = {
  "w0": {
    "gk": "0",
    "def": ["0", "0", "0"],
    "mid": ["0", "0", "0", "0"],
    "att": ["0", "0", "0"],
    "subs": ["0", "0", "0"],
  }
};

class Manager {
  String firebaseID;
  String email;
  String fullname;
  String username;
  String phonenumber;
  String teamName;
  bool benchBoost;
  bool tripleCaptain;
  bool freeHit;
  bool wildcard;
  bool isMale;
  int totalPoints;
  int currentWeekPoints;
  int freeTransfers;
  bool initializedTeam;
  Map<String, int> pointsHistory;
  Squad currentSquad;
  Map<String, Map<String, dynamic>> squadHistory;
  Manager({
    required this.firebaseID,
    required this.fullname,
    required this.email,
    required this.phonenumber,
    required this.isMale,
    required this.username,
    required this.teamName,
    this.initializedTeam = false,
    this.benchBoost = true,
    this.tripleCaptain = true,
    this.freeHit = true,
    this.wildcard = true,
    this.freeTransfers = 1,
    this.totalPoints = 0,
    this.currentWeekPoints = 0,
    this.pointsHistory = pointsHistoryE,
    this.squadHistory = squadHistoryE,
    required this.currentSquad,
  });

  Manager.fromJson(Map<String, dynamic> json)
      : this(
          firebaseID: json['firebaseID'] as String,
          fullname: json['fullname'] as String,
          email: json['email'] as String,
          phonenumber: json['phonenumber'] as String,
          isMale: json['isMale'] as bool,
          totalPoints: json['totalPoints'] as int,
          currentWeekPoints: json['currentWeekPoints'] as int,
          pointsHistory: Map<String, int>.from(json['pointsHistory']),
          currentSquad: Squad.fromJson(json['currentSquad']),
          squadHistory:
              Map<String, Map<String, dynamic>>.from(json['squadHistory']),
          username: json['username'] as String,
          benchBoost: json['benchBoost'] as bool,
          tripleCaptain: json['tripleCaptain'] as bool,
          freeHit: json['freeHit'] as bool,
          wildcard: json['wildcard'] as bool,
          freeTransfers: json['freeTransfers'] as int,
          teamName: json['teamName'] as String,
          initializedTeam: json['initializedTeam'] as bool,
        );

  Map<String, Object> toJson() {
    return {
      'firebaseID': firebaseID,
      'fullname': fullname,
      'email': email,
      'phonenumber': phonenumber,
      'isMale': isMale,
      'totalPoints': totalPoints,
      'currentWeekPoints': currentWeekPoints,
      'pointsHistory': pointsHistory,
      'currentSquad': currentSquad.toJson(),
      'squadHistory': squadHistory,
      'username': username,
      'benchBoost': benchBoost,
      'tripleCaptain': tripleCaptain,
      'freeHit': freeHit,
      'wildcard': wildcard,
      'freeTransfers': freeTransfers,
      'teamName': teamName,
      'initializedTeam': initializedTeam,
    };
  }
}
