import 'package:fantasyapp/models/squad.dart';

class TeamLab {
  final List<Squad> _teams = [];
  static TeamLab? sTeamLab;

  static TeamLab get() {
    sTeamLab = TeamLab();
    return sTeamLab!;
  }

  void addTeam(Squad team) {
    sTeamLab!.teams.add(team);
  }

  TeamLab();

  TeamLab.fromJson(List<dynamic> json) {
    sTeamLab = TeamLab();
    for (Map<String, dynamic> teamJson in json) {
      addTeam(Squad.fromJson(teamJson));
    }
  }

  List<Squad> get teams => _teams;
}
