import 'package:fantasyapp/widgets/MatchCardWidget.dart';
import 'package:flutter/material.dart';

import '../../vars.dart';
class MatchScreen extends StatefulWidget  {
   const MatchScreen({super.key});
// ignore: prefer_typing_uninitialized_variables
  @override
 State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State <MatchScreen> {
bool PREVIOUS = false;




  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body:
  Column(children: [
    SizedBox(height: 20),
    AnimatedPositioned(
            duration: const Duration(milliseconds: 80),
            curve: Curves.bounceInOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              curve: Curves.bounceInOut,
              // height: buyWidget ? 200 : 280,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              PREVIOUS = true;
                            });
                          },
                          child: Padding(padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            ),
                          child: Container (
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                              decoration: BoxDecoration(
    border: PREVIOUS == true ? Border(bottom: BorderSide(color: kPlayerCardColorPrimary)): null,
  ),
                              child:  
                               Text(
                                "Previous Matchs",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // decoration: PREVIOUS == true ? TextDecoration.underline : TextDecoration.none
                                )))
                           
                        )),
                         GestureDetector(
                          onTap: () {
                            setState(() {
                              PREVIOUS= false;
                            });
                          },
                          child: Column(
                            children:  [
                            Padding(padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            
                            ), 
                            child: Container (
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                              decoration: BoxDecoration(
    border: PREVIOUS != true ? Border(bottom: BorderSide(color: kPlayerCardColorPrimary)): null,
  ),
                              child:  
                            Text(
                                "Upcoming Matchs",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                              ),
                          )),

                          )],
                    ))]),
                    if (PREVIOUS) buildPreviousMatchsSection(),
                    if (!PREVIOUS) buildUpcomingMatchsSection()
                  ],
                ),
              ),
            ),
         )] ));
  }
   Container buildPreviousMatchsSection() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
      child: Column( 
        children: const [
           MatchCardScreen(date: 'Terminé 03/09', team1: 'Hammam-Sousse', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png', scoreteam1: 0, scoreteam2: 1, score: true),
          MatchCardScreen(date: 'Terminé 03/09', team1: 'Stade Tunisien', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png', scoreteam1: 1, scoreteam2: 1, score: true),
          MatchCardScreen(date: 'Terminé 03/09', team1: 'ESS', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png', scoreteam1: 2, scoreteam2: 1, score: true),
          MatchCardScreen(date: 'Terminé 03/09', team1: 'ESS', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png', scoreteam1: 0, scoreteam2: 0, score: true),
          ]
          )
          );
          
          }
  Container buildUpcomingMatchsSection() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
      child: Column(children: const [
        MatchCardScreen(date: 'jeu 06/10 8:00 PM', team1: 'Hammam-Sousse', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png', scoreteam1: 0, scoreteam2: 0, score: false),
        MatchCardScreen(date: 'TBC', team1: 'ESS', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png',  scoreteam1: 0, scoreteam2: 0, score: false),
        MatchCardScreen(date: 'ven 07/10 8:00 PM', team1: 'ESS', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png',  scoreteam1: 0, scoreteam2: 0, score: false),
        MatchCardScreen(date: 'jeu 06/10 8:00 PM', team1: 'ESS', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png',  scoreteam1: 0, scoreteam2: 0, score: false),
        MatchCardScreen(date: 'jeu 06/10 8:00 PM', team1: 'ESS', team1logo: 'images/ess-logo.png', team2: 'CA', team2logo: 'images/ca-logo.png',  scoreteam1: 0, scoreteam2: 0, score: false),
      ],)
    );
  }
}