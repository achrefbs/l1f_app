import 'package:fantasyapp/models/squad.dart';
import 'package:fantasyapp/team_lab.dart';
import 'package:flutter/material.dart';

class TeamsDetailsView extends StatefulWidget {
  const TeamsDetailsView({super.key});

  @override
  TeamsDetailsViewState createState() => TeamsDetailsViewState();
}

class TeamsDetailsViewState extends State<TeamsDetailsView> {
  bool sortDesc = true,
      sortName = false,
      sortOwner = false,
      sortValue = false,
      sortPoints = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teams"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = true;
                        sortOwner = false;
                        sortValue = false;
                        sortPoints = false;
                        TeamLab.get().teams.sort((Squad a, Squad b) {
                          if (sortDesc) {
                            return a.name
                                .toLowerCase()
                                .compareTo(b.name.toLowerCase());
                          } else {
                            return b.name
                                .toLowerCase()
                                .compareTo(a.name.toLowerCase());
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text("Name"),
                        ),
                        (sortName)
                            ? Icon((sortDesc)
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up)
                            : Container()
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = false;
                        sortOwner = true;
                        sortValue = false;
                        sortPoints = false;
                        TeamLab.get().teams.sort((Squad a, Squad b) {
                          if (sortDesc) {
                            return a.owner
                                .toLowerCase()
                                .compareTo(b.owner.toLowerCase());
                          } else {
                            return b.owner
                                .toLowerCase()
                                .compareTo(a.owner.toLowerCase());
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text("Onwer"),
                        ),
                        (sortOwner)
                            ? Icon((sortDesc)
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up)
                            : Container()
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = false;
                        sortOwner = false;
                        sortValue = true;
                        sortPoints = false;
                        TeamLab.get().teams.sort((Squad a, Squad b) {
                          if (sortDesc) {
                            return a.price.compareTo(b.price);
                          } else {
                            return b.price.compareTo(a.price);
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text("Value"),
                        ),
                        (sortValue)
                            ? Icon((sortDesc)
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up)
                            : Container()
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        (sortDesc) ? sortDesc = false : sortDesc = true;
                        sortName = false;
                        sortOwner = false;
                        sortValue = false;
                        sortPoints = true;
                        TeamLab.get().teams.sort((Squad a, Squad b) {
                          if (sortDesc) {
                            return a.points.compareTo(b.points);
                          } else {
                            return b.points.compareTo(a.points);
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text("Points"),
                        ),
                        (sortPoints)
                            ? Icon((sortDesc)
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up)
                            : Container()
                      ],
                    )),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                Squad team = TeamLab.get().teams[index];
                return InkWell(
                    onTap: () => {}
                    // Navigator.push(context,
                    //         MaterialPageRoute(builder: (BuildContext context) {
                    //       return TeamOtherDisplayView(
                    //         team: team,
                    //       );
                    //     }))
                    ,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(team.name),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(team.owner),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(team.price.toString()),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(team.points.toString()),
                        ),
                      ],
                    ));
              },
              itemCount: TeamLab.get().teams.length,
            ),
          )
        ],
      ),
    );
  }
}
