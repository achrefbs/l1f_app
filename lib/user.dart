import 'package:fantasyapp/team.dart';

class UserB {
  late int userId;
  late int teamId;
  late String username;
  late int adminedTeam;
  late bool isSuperAdmin;
  static UserB? sUser;
  late TeamB team;

  UserB({
    required this.userId,
    required this.teamId,
    required this.username,
    required this.adminedTeam,
    required this.isSuperAdmin,
    required this.team,
  });

  UserB.fromJson(Map<String, dynamic> json, String username) {
    create(
      int.parse(json['user_id']),
      int.parse(json['team_id']),
      username,
      int.parse(json['admined_team']),
      json['is_super_admin'] == 1,
    );
  }

  static UserB get() {
    TeamB t = TeamB(0, "", "", 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0);

    return UserB(
      adminedTeam: 0,
      isSuperAdmin: true,
      teamId: 0,
      userId: 0,
      username: '',
      team: t,
    );
  }

  static void create(int userId, int teamId, String username, int adminedTeam,
      bool isSuperAdmin) {
    TeamB t = TeamB(0, "", "", 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0);
    sUser ??= UserB(
      adminedTeam: adminedTeam,
      isSuperAdmin: isSuperAdmin,
      teamId: teamId,
      userId: userId,
      username: username,
      team: t,
    );
  }

  void clearUser() {
    sUser = null;
  }
}
