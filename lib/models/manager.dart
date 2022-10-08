import 'package:fantasyapp/models/squad.dart';

class Manager {
  late String userId;
  late String username;
  late bool isSuperAdmin;
  late Squad team;
  late String email;

  Manager({
    required this.userId,
    required this.username,
    required this.isSuperAdmin,
    required this.team,
    required this.email,
  });

  Manager.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    isSuperAdmin = json['isSuperAdmin'];
    team = (json['team'] != null ? Squad.fromJson(json['team']) : null)!;
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        'is_super_admin': isSuperAdmin,
        'team': team.toJson(),
        'email': email,
      };
}
