import 'package:fantasyapp/playerB.dart';
import 'package:fantasyapp/player_update_lab.dart';
import 'package:fantasyapp/team.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class InternetAsync {
  final playersRef =
      FirebaseFirestore.instance.collection('Players').withConverter<PlayerB>(
            fromFirestore: (snapshot, _) {
              return PlayerB.fromJson(
                snapshot.data() ?? {},
              );
            },
            toFirestore: (player, _) => player.toJson(),
          );
  final usersRef =
      FirebaseFirestore.instance.collection('Users').withConverter<PlayerB>(
            fromFirestore: (snapshot, _) {
              return PlayerB.fromJson(
                snapshot.data() ?? {},
              );
            },
            toFirestore: (player, _) => player.toJson(),
          );
  final teamsRef =
      FirebaseFirestore.instance.collection('Teams').withConverter<TeamB>(
            fromFirestore: (snapshot, _) {
              return TeamB.fromJson(
                snapshot.data() ?? {},
              );
            },
            toFirestore: (player, _) => player.toJson(),
          );
  updatePlayerStats(context) async {
    PlayerUpdateLab playerUpdateLab = PlayerUpdateLab();

    try {
      await usersRef.doc("1").set(PlayerB.fromJson(playerUpdateLab.toJson()));
    } catch (e) {}
  }

  fetchUser(context, username, password) async {
    // UserB user = UserB.get()!;
    // return user;
  }

//the last fetch has to build the navigation drawer
  fetchAppState(context) async {}

  fetchPlayers(context) async {}

  fetchTeams(context) async {}

  Future updateTeam(context) async {}

  Future addTeam(context, TeamB team) async {
    try {
      await teamsRef.doc(team.owner).set(team);
    } catch (e) {}
  }

  addUser(context, String username, String email, String password) async {}

  addUserToDB(context, String username, String email, String password) async {}

  sendEmailResetPassword(context, String email) async {}

  checkPasswordResetCode(context, String email, String resetCode) async {}

  resetPassword(context, String email, String password) async {}
}
