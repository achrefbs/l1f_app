import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/models/player.dart';
import 'package:fantasyapp/models/squad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Errors {
  none,
  matchError,
  weakError,
  existsError,
  error,
  wrongError,
  noUserError,
  confirmMatchError,
}

Squad squad = Squad.empty();

class AuthHelper with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  Manager? current;
  Squad? currentSquad;

  final usersRef =
      FirebaseFirestore.instance.collection('Managers').withConverter<Manager>(
            fromFirestore: (snapshot, _) {
              return Manager.fromJson(
                snapshot.data()!,
              );
            },
            toFirestore: (user, _) => user.toJson(),
          );
  final squadRef =
      FirebaseFirestore.instance.collection('Squads').withConverter<Squad>(
            fromFirestore: (snapshot, _) {
              return Squad.fromJson(
                snapshot.data()!,
              );
            },
            toFirestore: (squad, _) => squad.toJson(),
          );

  get isLoggedIn => auth.currentUser != null;

  Future attemptSignUp({
    required String username,
    required String email,
    required String password,
    required String teamName,
    required String confirm,
    required int currentWeek,
  }) async {
    Manager manager;
    if (password == confirm) {
      try {
        squad.name = teamName;
        squad.owner = username;

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        manager = Manager(
          currentWeek: currentWeek,
          userId: userCredential.user!.uid,
          username: username,
          isSuperAdmin: false,
          currentSquad: squad.squadID,
          email: email,
        );

        usersRef.add(
          manager,
        );
      } on FirebaseAuthException catch (_) {
        return Errors.error;
      }
      current = manager;
      return Errors.none;
    } else {
      return Errors.confirmMatchError;
    }
  }

  attemptLogin(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Errors.noUserError;
      } else if (e.code == 'wrong-password') {
        return Errors.wrongError;
      }
    }
    return Errors.none;
  }

  logout() {
    auth.signOut();
    notifyListeners();
  }

  //get current manager
  Future<Manager> getCurrentManager() async {
    if (current == null) {
      final user = auth.currentUser;
      await usersRef.where('user_id', isEqualTo: user!.uid).get().then((value) {
        current = value.docs.first.data();
      });
    }
    return current!;
  }

  Future<Squad> getCurrentSquad() async {
    if (currentSquad == null) {
      await squadRef
          .where('squadID', isEqualTo: current!.currentSquad)
          .get()
          .then((value) {
        currentSquad = value.docs.first.data();
      });
    }
    return squad;
  }

  setSquad(List<Player> players, double price) async {
    final user = auth.currentUser;
    squad.price = price;
    squad.defNum = 3;
    squad.midNum = 4;
    squad.fwdNum = 3;
    squad.emptyPlayers();
    squad.addPlayer(players[0]);
    squad.addPlayer(players[2]);
    squad.addPlayer(players[3]);
    squad.addPlayer(players[4]);
    squad.addPlayer(players[7]);
    squad.addPlayer(players[8]);
    squad.addPlayer(players[9]);
    squad.addPlayer(players[10]);
    squad.addPlayer(players[12]);
    squad.addPlayer(players[13]);
    squad.addPlayer(players[14]);
    squad.addPlayer(players[1]);
    squad.addPlayer(players[5]);
    squad.addPlayer(players[6]);
    squad.addPlayer(players[11]);
    await squadRef.add(squad);
    await usersRef.where('user_id', isEqualTo: user!.uid).get().then((value) {
      value.docs[0].reference.update({'currentSquad': squad.squadID});
    }).onError((error, stackTrace) {});

    notifyListeners();
  }

  Future<Squad> getSquad(String squadId) async {
    var s;
    await squadRef.where('squadID', isEqualTo: squadId).get().then((value) {
      s = value.docs.first.data();
    });
    return s;
  }

  //update squad
  updateSquad() {
    squadRef
        .where('squadID', isEqualTo: current!.currentSquad)
        .get()
        .then((value) {
      value.docs[0].reference.update(currentSquad!.toJson());
    });
  }
}
