import 'package:fantasyapp/models/player.dart';
import 'package:fantasyapp/player_details_view.dart';
import 'package:fantasyapp/player_lab.dart';
import 'package:flutter/material.dart';

class PlayersDetailsView extends StatefulWidget {
  const PlayersDetailsView({Key? key}) : super(key: key);

  @override
  PlayersDetailsViewState createState() => PlayersDetailsViewState();
}

class PlayersDetailsViewState extends State<PlayersDetailsView> {
  bool _sortAsc = true;
  int _sortColumnIndex = 0;
  final double _columnWidth = 40.0;
  final double _columnNameWidth = 60.0;

  final PlayersDataSource _playersDataSource = PlayersDataSource();
  int _rowsPerPage = 20;

  void _sort<T>(Comparable<T> getField(p), int columnIndex, bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending;
    });
  }

  @override
  void initState() {
    super.initState();
    _sort<String>((p) => p.firstName, _sortColumnIndex, _sortAsc);
  }

  @override
  Widget build(BuildContext context) {
    _playersDataSource.context = context;
    return Scaffold(
        body: ListView(
      children: <Widget>[
        PaginatedDataTable(
          availableRowsPerPage: const [10, 20, 50],
          columnSpacing: 1.0,
          horizontalMargin: 1.0,
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (int? value) {
            setState(() {
              _rowsPerPage = value!;
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
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((p) => p.firstName, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(
                    width: _columnNameWidth,
                    child: const Text(
                      "Last Name",
                      softWrap: true,
                    )),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((p) => p.lastName, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(
                    width: _columnWidth, child: const Text("Position")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<String>((p) => p.position, columnIndex, ascending)),
            DataColumn(
                label:
                    SizedBox(width: _columnWidth, child: const Text("Price")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.price, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(width: _columnWidth, child: const Text("Team")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.team, columnIndex, ascending)),
            DataColumn(
                label:
                    SizedBox(width: _columnWidth, child: const Text("Points")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.points, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(
                    width: _columnWidth, child: const Text("Week Points")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.pointsWeek, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(width: _columnWidth, child: const Text("Apps")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.appearances, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(
                    width: _columnWidth, child: const Text("Sub Apps")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (p) => p.subAppearances, columnIndex, ascending)),
            DataColumn(
                label:
                    SizedBox(width: _columnWidth, child: const Text("Goals")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.goals, columnIndex, ascending)),
            DataColumn(
                label:
                    SizedBox(width: _columnWidth, child: const Text("Assists")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.assists, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(width: _columnWidth, child: const Text("CSs")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.cleanSheets, columnIndex, ascending)),
            DataColumn(
                label:
                    SizedBox(width: _columnWidth, child: const Text("MOTMs")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.motms, columnIndex, ascending)),
            DataColumn(
                label:
                    SizedBox(width: _columnWidth, child: const Text("Yellows")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.yellowCards, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(width: _columnWidth, child: const Text("Reds")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.redCards, columnIndex, ascending)),
            DataColumn(
                label: SizedBox(
                    width: _columnWidth, child: const Text("Own Goals")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((p) => p.ownGoals, columnIndex, ascending)),
            DataColumn(
                label:
                    SizedBox(width: _columnWidth, child: const Text("Fresher")),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (p) => p.isFresher.toString(), columnIndex, ascending)),
          ],
          source: _playersDataSource,
        )
      ],
    ));
  }
}

class PlayersDataSource extends DataTableSource {
  late BuildContext _context;

  void _sort<T>(Comparable<T> getField(p), bool ascending) {
    _players.sort((a, b) {
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

  PlayersDataSource();

  set context(BuildContext value) {
    _context = value;
  }

  final List<Player> _players = PlayerLab.get().players;

  final int _selectedCount = 0;
  final double _columnWidth = 40.0;
  final double _columnNameWidth = 60.0;

  DataCell getCell(String text, Player player) {
    return DataCell(
        SizedBox(
            width: _columnWidth,
            child: Text(
              text,
              overflow: TextOverflow.fade,
              softWrap: false,
            )), onTap: () {
      Navigator.push(_context,
          MaterialPageRoute(builder: (BuildContext context) {
        return PlayerDetailsView(player);
      }));
    });
  }

  DataCell getNameCell(String text, Player player) {
    return DataCell(
        SizedBox(
            width: _columnNameWidth,
            child: Text(
              text,
              overflow: TextOverflow.fade,
              softWrap: false,
            )), onTap: () {
      Navigator.push(_context,
          MaterialPageRoute(builder: (BuildContext context) {
        return PlayerDetailsView(player);
      }));
    });
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _players.length) return const DataRow(cells: []);
    final Player player = _players[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      getNameCell(player.firstName, player),
      getNameCell(player.lastName, player),
      getCell(player.position, player),
      getCell('${player.price}', player),
      getCell('${player.team}', player),
      getCell('${player.points}', player),
      getCell('${player.pointsWeek}', player),
      getCell('${player.appearances}', player),
      getCell('${player.subAppearances}', player),
      getCell('${player.goals}', player),
      getCell('${player.assists}', player),
      getCell('${player.cleanSheets}', player),
      getCell('${player.motms}', player),
      getCell('${player.yellowCards}', player),
      getCell('${player.redCards}', player),
      getCell('${player.ownGoals}', player),
    ]);
  }

  @override
  int get rowCount => _players.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
