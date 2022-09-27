import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/team_history_screen.dart';
import 'package:fantasyapp/widgets/border_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthHelper auth = Provider.of<AuthHelper>(context);
    Manager manager = auth.current!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BorderCard(
          flex: 1,
          widget: Text(manager.username),
        ),
        BorderCard(
          flex: 1,
          widget: Column(children: [
            Text("Game Week: ${auth.currentGameWeek}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TeamHistoryScreen(
                        manager: manager,
                      ),
                    ),
                  ),
                  child: Text("Points: ${auth.current!.currentWeekPoints}"),
                ),
                FutureBuilder(
                    future: auth.getHighestPointsManager(),
                    builder: (context, AsyncSnapshot<Manager> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("something went wrong!");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                            "Highest: ${snapshot.data!.currentWeekPoints}");
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
