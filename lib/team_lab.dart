import 'package:fantasyapp/team.dart';
import 'package:fantasyapp/user.dart';

class TeamLab {
  final List<TeamB> _teams = [];
  static TeamLab? sTeamLab;

  static TeamLab get() {
    sTeamLab = TeamLab();
    return sTeamLab!;
  }

  void addTeam(TeamB team) {
    UserB user = UserB.get();
    if (team.teamId == user.teamId) {
      user.team = team;
    }
    sTeamLab!.teams.add(team);
  }

  TeamLab();

  TeamLab.fromJson(List<dynamic> json) {
    sTeamLab = TeamLab();
    for (Map<String, dynamic> teamJson in json) {
      addTeam(TeamB.fromTeamsJson(teamJson));
    }
  }

  List<TeamB> get teams => _teams;
}
