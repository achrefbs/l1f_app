class Squad {
  String gk;
  List<String> def;
  List<String> mid;
  List<String> att;
  List<String> subs;

  Squad({
    this.gk = "0",
    this.def = const ["0", "0", "0"],
    this.mid = const ["0", "0", "0", "0"],
    this.att = const ["0", "0", "0"],
    this.subs = const ["0", "0", "0", "0"],
  });

  Squad.fromJson(Map<String, dynamic> json)
      : this(
          gk: json['gk'] as String,
          def: List<String>.from(json['def']),
          mid: List<String>.from(json['mid']),
          att: List<String>.from(json['att']),
          subs: List<String>.from(json['subs']),
        );

  Map<String, dynamic> toJson() => {
        'gk': gk,
        'def': def,
        'mid': mid,
        'att': att,
        'subs': subs,
      };
}
