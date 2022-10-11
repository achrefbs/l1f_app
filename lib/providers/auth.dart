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
}

Squad squad = Squad.empty();

class AuthHelper with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  Manager? current;

  final usersRef =
      FirebaseFirestore.instance.collection('Managers').withConverter<Manager>(
            fromFirestore: (snapshot, _) {
              return Manager.fromJson(
                snapshot.data()!,
              );
            },
            toFirestore: (user, _) => user.toJson(),
          );

  get isLoggedIn => auth.currentUser != null;

  Future attemptSignUp({
    required String username,
    required String email,
    required String password,
    required String teamName,
  }) async {
    Manager manager;
    try {
      squad.name = teamName;
      squad.owner = username;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      manager = Manager(
        userId: userCredential.user!.uid,
        username: username,
        isSuperAdmin: false,
        squad: squad,
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
      final manager = await usersRef
          .where('user_id', isEqualTo: user!.uid)
          .get()
          .then((value) {});

      current = manager;
    }
    return current!;
  }

  setSquad(List<Player> players, double price) async {
    final user = auth.currentUser;
    current!.squad.price = price;
    current!.squad.emptyPlayers();
    current!.squad.addPlayer(players[0]);
    current!.squad.addPlayer(players[0]);
    current!.squad.addPlayer(players[2]);
    current!.squad.addPlayer(players[3]);
    current!.squad.addPlayer(players[4]);
    current!.squad.addPlayer(players[7]);
    current!.squad.addPlayer(players[8]);
    current!.squad.addPlayer(players[9]);
    current!.squad.addPlayer(players[10]);
    current!.squad.addPlayer(players[12]);
    current!.squad.addPlayer(players[13]);
    current!.squad.addPlayer(players[14]);
    current!.squad.addPlayer(players[1]);
    current!.squad.addPlayer(players[15]);
    current!.squad.addPlayer(players[11]);
    current!.squad.addPlayer(players[5]);
    current!.squad.addPlayer(players[6]);

    await usersRef.where('user_id', isEqualTo: user!.uid).get().then((value) {
      value.docs[0].reference.update({'squad': current!.squad.toJson()});
    }).onError((error, stackTrace) {});

    notifyListeners();
  }
}
