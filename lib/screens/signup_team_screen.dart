import 'package:fantasyapp/screens/login_screen.dart';
import 'package:fantasyapp/screens/pages/create_team_page.dart';
import 'package:fantasyapp/screens/pick_team_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../vars.dart';

class SignUpTeamScreen extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const SignUpTeamScreen({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  createState() => SignUpTeamScreenState();
}

class SignUpTeamScreenState extends State<SignUpTeamScreen> {
  TextEditingController teamNameController = TextEditingController();

  var totalPhotosCount = 0;
  var favteamclick = 0;
  @override
  Widget build(BuildContext context) {
    Widget teamPhotos = StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('favteams').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error in receiving teams photos: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            final teamPhotos = snapshot.data?.docs ?? [];
            if (teamPhotos.isNotEmpty) {
              return GridView.builder(
                  itemCount: teamPhotos.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    var image = teamPhotos[index]['image'];
                    return Center(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: index == favteamclick
                              ? BoxDecoration(
                                  border: Border.all(
                                  width: 1,
                                ))
                              : null,
                          child: InkWell(
                            child: Image.asset(
                              image.toString(),
                              height: 50,
                              width: 100,
                            ),
                            onTap: () {
                              setState(() {
                                favteamclick = index;
                              });
                            },
                          )),
                    );
                  });
            }
          }
          return const Text('No team photos found.');
        });

    // final controller = GroupButtonController();
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Positioned(
                      bottom: 50,
                      left: 30,
                      right: 20,
                      top: 100,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              boxShadow: const [
                                // BoxShadow(
                                //     color: Colors.black.withOpacity(0.7),
                                //     blurRadius: 15,
                                //     spreadRadius: 5),
                              ]),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Column(children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        controller: teamNameController,
                                        decoration: const InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          hintText: 'team name',
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: kPlayerCardColorPrimary,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Select your favorite team',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: teamPhotos),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateTeamView(
                                            email: widget.email,
                                            password: widget.password,
                                            username: widget.username,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: kTransparentBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Already have an account?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text('Login',
                                          style: TextStyle(
                                              color: kPlayerCardColorPrimary)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )))
                ])));
  }
}
