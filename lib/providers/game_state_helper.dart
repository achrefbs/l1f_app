import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasyapp/models/game_state.dart';
import 'package:fantasyapp/models/manager.dart';
import 'package:flutter/material.dart';

class GameStateHelper extends ChangeNotifier {
  GameState? gameState;
  final usersRef =
      FirebaseFirestore.instance.collection('Managers').withConverter<Manager>(
            fromFirestore: (snapshot, _) {
              return Manager.fromJson(
                snapshot.data() ?? {},
              );
            },
            toFirestore: (user, _) => user.toJson(),
          );

  //get game week
  GameState getCurrentGameState() {
    return gameState ?? GameState(currentGameWeek: 0);
  }

  final gameStateRef = FirebaseFirestore.instance
      .collection('GameState')
      .withConverter<GameState>(
        fromFirestore: (snapshot, _) {
          return GameState.fromJson(snapshot.data() ?? {});
        },
        toFirestore: (state, _) => state.toJson(),
      );

  Future<void> getGameState() async {
    await gameStateRef.doc('gameState').get().then((value) {
      gameState = value.data()!;
    });
  }

  GameStateHelper() {
    getGameState().then((value) {
      notifyListeners();
    });
  }

  //get highest points manager for gameweek
  Future<Manager> getHighestPointsManager() async {
    final manager = await usersRef
        .orderBy('currentWeekPoints', descending: true)
        .limit(1)
        .get()
        .then((value) => value.docs.first.data());
    return manager;
  }
}
