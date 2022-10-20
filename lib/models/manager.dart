class Manager {
  late String userId;
  late String username;
  late bool isSuperAdmin;
  late String currentSquad;
  late List<String> squadHistory;
  late String email;

  Manager({
    required this.userId,
    required this.username,
    required this.isSuperAdmin,
    required this.currentSquad,
    required this.email,
    required currentWeek,
  }) {
    squadHistory = [];
    squadHistory.add(currentSquad);
  }

  Manager.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    isSuperAdmin = json['is_super_admin'];
    currentSquad = json['currentSquad'];
    email = json['email'];
    squadHistory = json['squad_history'].cast<String>();
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        'is_super_admin': isSuperAdmin,
        'currentSquad': currentSquad,
        'email': email,
        'squad_history': squadHistory,
      };
}
