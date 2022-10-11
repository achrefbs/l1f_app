import 'package:fantasyapp/leaderboard_view.dart';
import 'package:fantasyapp/players_details_view.dart';
import 'package:fantasyapp/team_display_view.dart';
import 'package:fantasyapp/teams_details_view.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  NavigationDrawerState createState() => NavigationDrawerState();
}

class NavigationDrawerState extends State<NavigationDrawer> {
  Widget widgetForBody = const TeamDisplayView();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
              title: const Text("IC Fantasy Football"),
              backgroundColor: Colors.blueAccent),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("My Team"),
                    onTap: () {
                      setState(() {
                        widgetForBody = const TeamDisplayView();
                      });
                      Navigator.pop(context);
                    }),
                ListTile(
                    title: const Text("Teams"),
                    leading: const Icon(Icons.people),
                    onTap: () {
                      setState(() {
                        widgetForBody = const TeamsDetailsView();
                      });
                      Navigator.pop(context);
                    }),
                ListTile(
                    title: const Text("Players"),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      setState(() {
                        widgetForBody = const PlayersDetailsView();
                      });
                      Navigator.pop(context);
                    }),
                ListTile(
                    title: const Text("LeaderBoards"),
                    leading: const Icon(Icons.format_list_numbered),
                    onTap: () {
                      setState(() {
                        widgetForBody = const LeaderboardView();
                      });
                      Navigator.pop(context);
                    }),
                const Divider(),
                // new ListTile(
                //   title: new Text("Log out"),
                //   leading: new Icon(Icons.exit_to_app),
                //   onTap: () {
                //     UserB.get()!.clearUser();
                //     Navigator.pushReplacement(context,
                //         MaterialPageRoute(builder: (BuildContext context) {
                //       return LoginView();
                //     }));
                //   },
                // ),
                // ListTile(
                //   title: const Text("Cancel"),
                //   leading: const Icon(Icons.cancel),
                //   onTap: () => Navigator.pop(context),
                // ),
                // (Manager.get().adminedTeam != 0)
                //     ? const Divider()
                //     : Container(),
                // (Manager.get().adminedTeam != 0)
                //     ? const Padding(
                //         padding: EdgeInsets.only(left: 10),
                //         child: Text(
                //           "Admin",
                //           style: TextStyle(fontWeight: FontWeight.bold),
                //         ))
                //     : Container(),
                // (Manager.get().adminedTeam != 0)
                //     ? new ListTile(
                //         title: new Text("Set Team Stats"),
                //         leading: new Icon(Icons.add_box),
                //         onTap: () {
                //           setState(() {
                //             widgetForBody = SetTeamStatsStartView();
                //           });
                //           Navigator.pop(context);
                //         })
                //     : Container(),
              ],
            ),
          ),
          body: widgetForBody),
    );
  }
}
