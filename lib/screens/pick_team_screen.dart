import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/vars.dart';
import 'package:fantasyapp/widgets/header.dart';
import 'package:fantasyapp/widgets/pickteamscreen/attack_line.dart';
import 'package:fantasyapp/widgets/pickteamscreen/defence_line.dart';
import 'package:fantasyapp/widgets/pickteamscreen/mid_line.dart';
import 'package:fantasyapp/widgets/pickteamscreen/subtitute_line.dart';
import 'package:flutter/material.dart';

class PickTeamScreen extends StatelessWidget {
  const PickTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              HeaderWidget(
                title: 'Pick Team',
                navigateTo: const HomeScreen(),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: kBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white24,
                      ),
                    ),
                    const Text("Gameweek 1",
                        style: TextStyle(color: kBarTextColor)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: kBarTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: kSnackBarColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: const [
                    Icon(
                      Icons.compare_arrows,
                      color: kSnackBarTextColorPrimary,
                    ),
                    SizedBox(width: 8),
                    Text('Transfer deadline:',
                        style: TextStyle(color: kSnackBarTextColorPrimary)),
                    SizedBox(width: 8),
                    Text(
                      '28 Sep, 20:00',
                      style: TextStyle(color: kSnackBarTextColorSecondary),
                    )
                  ]),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/pitch22.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: const [
                          SizedBox(height: 40),
                          //GoadLine(),
                          SizedBox(height: 20),
                          DefenceLine(),
                          SizedBox(height: 20),
                          MidLine(),
                          SizedBox(height: 20),
                          AttackLine(),
                          SizedBox(height: 110),
                          SubstituteLine(),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kTransparentBackgroundColor,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "+ Chips",
                            style: TextStyle(color: kBarTextColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
