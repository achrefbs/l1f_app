import 'package:fantasyapp/models/squad.dart';
import 'package:fantasyapp/playerB.dart';
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
      FirebaseFirestore.instance.collection('Teams').withConverter<Squad>(
            fromFirestore: (snapshot, _) {
              return Squad.fromJson(
                snapshot.data() ?? {},
              );
            },
            toFirestore: (player, _) => player.toJson(),
          );

  // updatePlayerStats(context) async {
  //   PlayerUpdateLab playerUpdateLab = PlayerUpdateLab();

  //   try {
  //     await usersRef.doc("1").set(PlayerB.fromJson(playerUpdateLab.toJson()));
  //   } catch (e) {}
  // }

  fetchUser(context, username, password) async {
    // UserB user = UserB.get()!;
    // return user;
  }

//the last fetch has to build the navigation drawer
  fetchAppState(context) async {}

  fetchPlayers(context) async {}

  fetchTeams(context) async {}

  Future updateTeam(context) async {}

  Future<Squad> addTeam(context, Squad team) async {
    try {
      await teamsRef.add(team);
      return team;
    } catch (e) {
      print(e);
      return team;
    }
  }

  addUser(context, String username, String email, String password) async {}

  addUserToDB(context, String username, String email, String password) async {}

  sendEmailResetPassword(context, String email) async {}

  checkPasswordResetCode(context, String email, String resetCode) async {}

  resetPassword(context, String email, String password) async {}
}
