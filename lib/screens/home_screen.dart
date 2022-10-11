import 'package:fantasyapp/models/manager.dart';
import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/login_screen.dart';
import 'package:fantasyapp/screens/pages/home_page.dart';
import 'package:fantasyapp/screens/pick_team_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _items = [
    const HomePage(),
    // const FixturesPage(),
    // const PickTeamScreen(),
    //const FantasyPage(),
  ];
  int selectedIndex = 0;

  late Future<Manager> currentManager;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthHelper auth = Provider.of<AuthHelper>(context);
    if (auth.isLoggedIn) {
      currentManager = auth.getCurrentManager();
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TextButton(
                onPressed: (() {
                  auth.logout();
                }),
                child: const Text("logout"),
              ),
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => const PickTeamScreen()),
        ),
      );
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
