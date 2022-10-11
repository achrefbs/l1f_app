import 'package:fantasyapp/models/player.dart';
import 'package:fantasyapp/player_lab.dart';
import 'package:fantasyapp/screens/pages/create_team_page.dart';
import 'package:flutter/material.dart';

class PlayersCreationDetailsView extends StatefulWidget {
  final List<Player> selectedPlayers;
  final int playerIndex;

  const PlayersCreationDetailsView(
      {super.key, required this.selectedPlayers, required this.playerIndex});

  @override
  PlayersCreationDetailsViewState createState() =>
      PlayersCreationDetailsViewState();
}

class PlayersCreationDetailsViewState
    extends State<PlayersCreationDetailsView> {
  bool _sortAsc = false;
  int _sortColumnIndex = 0;
  final double _columnWidth = 40.0;
  final double _columnNameWidth = 60.0;
  late PlayersDataSource _playersDataSource;
  late List<Player> _players;

  int? _rowsPerPage = 20;

  void _sort<T>(Comparable<T> Function(Player p) getField, int columnIndex,
      bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending;
    });
  }

  @override
  void initState() {
    List<Player> players = PlayerLab.get().players;
    //filter out players by position
    if (widget.playerIndex < 2) {
      _players =
          List<Player>.from(players.where((player) => player.position == "GK"));
    } else if (widget.playerIndex < 7) {
      _players = List<Player>.from(
          players.where((player) => player.position == "DEF"));
    } else if (widget.playerIndex < 12) {
      _players = List<Player>.from(
          players.where((player) => player.position == "MID"));
    } else {
      _players = List<Player>.from(
          players.where((player) => player.position == "FWD"));
    }
    //filter out players who are already selected
    for (Player player in widget.selectedPlayers) {
      _players.remove(player);
    }
    _playersDataSource = PlayersDataSource(
        widget.playerIndex, widget.selectedPlayers, _players, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: ListView(
          children: <Widget>[
            PaginatedDataTable(
              columnSpacing: 1.0,
              horizontalMargin: 1.0,
              availableRowsPerPage: const [10, 20, 50],
              rowsPerPage: _rowsPerPage!,
              onRowsPerPageChanged: (int? value) {
                setState(() {
                  _rowsPerPage = value;
                });
              },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAsc,
              header: const Text("Players"),
              columns: <DataColumn>[
                DataColumn(
                    label: SizedBox(
                        width: _columnNameWidth,
                        child: const Text(
                          "First Name",
                          softWrap: true,
                        )),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Player p) => p.firstName, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnNameWidth,
                        child: const Text(
                          "Last Name",
                          softWrap: true,
                        )),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Player p) => p.lastName, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Position")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Player p) => p.position, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Price")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.price, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Team")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.team, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Points")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.points, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Week Points")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.pointsWeek, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Apps")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.appearances, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Sub Apps")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.subAppearances,
                        columnIndex,
                        ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Goals")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.goals, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Assists")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.assists, columnIndex, ascending)),
                DataColumn(
                    label:
                        SizedBox(width: _columnWidth, child: const Text("CSs")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.cleanSheets, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("MOTMs")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.motms, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Yellows")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.yellowCards, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Reds")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.redCards, columnIndex, ascending)),
                DataColumn(
                    label: SizedBox(
                        width: _columnWidth, child: const Text("Own Goals")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>(
                        (Player p) => p.ownGoals, columnIndex, ascending)),
              ],
              source: _playersDataSource,
            )
          ],
        )));
  }
}

class PlayersDataSource extends DataTableSource {
  PlayersDataSource(
      this._playerIndex, this._selectedPlayers, this._players, this.context);

  final int _playerIndex;
  final List<Player> _players;
  final List<Player> _selectedPlayers;

  final int _selectedCount = 0;
  BuildContext context;
  final double _columnWidth = 40.0;
  final double _columnNameWidth = 60.0;

  void _sort<T>(Comparable<T> Function(Player p) getField, bool ascending) {
    _players.sort((Player a, Player b) {
      if (!ascending) {
        final Player c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  DataCell getCell(String text) {
    return DataCell(SizedBox(
        width: _columnWidth,
        child: Text(
          text,
          overflow: TextOverflow.fade,
          softWrap: false,
        )));
  }

  DataCell getNameCell(String text, bool isFresher) {
    if (isFresher) {
      return DataCell(SizedBox(
          width: _columnNameWidth,
          child: Text(text,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(decoration: TextDecoration.underline))));
    } else {
      return DataCell(SizedBox(
          width: _columnNameWidth,
          child: Text(
            text,
            overflow: TextOverflow.fade,
            softWrap: false,
          )));
    }
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _players.length) return const DataRow(cells: []);
    final Player player = _players[index];
    return DataRow.byIndex(
        onSelectChanged: (b) {
          _players.removeAt(index);
          _selectedPlayers[_playerIndex] = player;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CreateTeamView(
              selectedPlayers: _selectedPlayers,
            );
          }));
        },
        index: index,
        cells: <DataCell>[
          getNameCell(player.firstName, false),
          getNameCell(player.lastName, false),
          getCell(player.position),
          getCell('${player.price}'),
          getCell('${player.team}'),
          getCell('${player.points}'),
          getCell('${player.pointsWeek}'),
          getCell('${player.appearances}'),
          getCell('${player.subAppearances}'),
          getCell('${player.goals}'),
          getCell('${player.assists}'),
          getCell('${player.cleanSheets}'),
          getCell('${player.motms}'),
          getCell('${player.yellowCards}'),
          getCell('${player.redCards}'),
          getCell('${player.ownGoals}'),
        ]);
  }

  @override
  int get rowCount => _players.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
