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
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      usersRef.add(
        Manager(
          userId: userCredential.user!.uid,
          username: username,
          isSuperAdmin: false,
          squad: squad,
          email: email,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Errors.weakError;
      } else if (e.code == 'email-already-in-use') {
        return Errors.existsError;
      } else {
        return Errors.error;
      }
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
          .where('user_id', isEqualTo: user!.uid)
          .get()
          .then((value) {
        print(value);
      });

      current = manager;
    }
    return current!;
  }

  setSquad(Squad squad) async {
    final user = auth.currentUser;
    await usersRef.where('user_id', isEqualTo: user!.uid).get().then((value) {
      value.docs[0].reference.update({'squad': squad.toJson()});
    });
    print(
        "squad set!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    notifyListeners();
  }
}
