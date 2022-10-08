import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasyapp/models/manager.dart';
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

class AuthHelper with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  Manager? current;

  final usersRef =
      FirebaseFirestore.instance.collection('Managers').withConverter<Manager>(
            fromFirestore: (snapshot, _) {
              return Manager.fromJson(
                snapshot.data() ?? {},
              );
            },
            toFirestore: (user, _) => user.toJson(),
          );

  get isLoggedIn => auth.currentUser != null;

  attemptSignUp({
    required String username,
    bool isSuperAdmin = false,
    required Squad team,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      usersRef
          .add(
            Manager(
              userId: userCredential.user!.uid,
              username: username,
              isSuperAdmin: isSuperAdmin,
              team: team,
              email: email,
            ),
          )
          .then((value) => print(value));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Errors.weakError;
      } else if (e.code == 'email-already-in-use') {
        return Errors.existsError;
      }
    } catch (e) {
      return Errors.error;
    }

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
          .where('firebaseID', isEqualTo: user!.uid)
          .get()
          .then((value) => value.docs.first.data());
      current = manager;
    }
    return current!;
  }
}
