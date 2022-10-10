import 'package:fantasyapp/models/squad.dart';

class Manager {
  late String userId;
  late String username;
  late bool isSuperAdmin;
  late Squad squad;
  late String email;

  Manager({
    required this.userId,
    required this.username,
    required this.isSuperAdmin,
    required this.squad,
    required this.email,
  });

  Manager.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    isSuperAdmin = json['is_super_admin'];
    squad = Squad.fromJson(json['squad']);
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        'is_super_admin': isSuperAdmin,
        'squad': squad.toJson(),
        'email': email,
      };
}
