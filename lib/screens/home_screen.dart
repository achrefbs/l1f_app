import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/login_screen.dart';
import 'package:fantasyapp/screens/pages/fixtures_page.dart';
import 'package:fantasyapp/screens/team_history_screen.dart';
import 'package:fantasyapp/team_display_view.dart';
import 'package:fantasyapp/teams_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_functions/cloud_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _items = [
    const FixturesPage(),
    const SizedBox(height: 600, child: TeamsDetailsView()),
    const SizedBox(height: 600, child: TeamDisplayView()),
  ];
  int selectedIndex = 0;

  late Future<Manager> currentManager;

  Future<void> getFruit() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('listFruit');
    final results = await callable();
    List fruit =
        results.data; // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
    print(fruit);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getFruit();

    AuthHelper auth = Provider.of<AuthHelper>(context);
    if (auth.isLoggedIn) {
      currentManager = auth.getCurrentManager();
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              FutureBuilder(
                  future: currentManager,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeamHistoryScreen(
                                  manager: snapshot.data as Manager,
                                ),
                              ),
                            );
                          },
                          child: const Text('Team History'),
                        ),
                        TextButton(
                          onPressed: () {
                            auth.logout();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  }),
              FutureBuilder(
                future: currentManager,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("something went wrong!"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _items[selectedIndex];
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: showBottomNav(),
      );
    } else {
      return const LoginScreen();
    }
  }

  Widget showBottomNav() {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Team',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
          ),
          label: 'ligues',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: _onTap,
    );
  }

  void _onTap(int index) {
    if (index == 2) {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: ((context) => const PickTeamScreen()),
      //   ),
      // );
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
    setState(() {
      selectedIndex = index;
    });
  }
}
