class GameState {
  int currentGameWeek;
  GameState({required this.currentGameWeek});
  GameState.fromJson(Map<String, dynamic> json)
      : currentGameWeek = json['currentGameWeek'];
  Map<String, dynamic> toJson() {
    return {
      'currentGameWeek': currentGameWeek,
    };
  }
}
