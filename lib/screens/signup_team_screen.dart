import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../vars.dart';

class SignUpTeamScreen extends StatefulWidget {
  final String email;
  final String fullname;
  final String password;
  final String phoneNumber;
  final bool isMale;
  final String username;
  final String teamName;

  const SignUpTeamScreen({
    super.key,
    required this.email,
    required this.password,
    required this.fullname,
    required this.username,
    required this.phoneNumber,
    required this.isMale,
    required this.teamName,
  });

  @override
  createState() => SignUpTeamScreenState();
}

class SignUpTeamScreenState extends State<SignUpTeamScreen> {
  TextEditingController teamNameController = TextEditingController();

  bool obscure = true;

  send(AuthHelper auth) {
    FocusScope.of(context).unfocus();
    var res = auth.attemptSignUp(
      teamName: teamNameController.text.trim(),
      email: widget.email,
      fullname: widget.fullname,
      password: widget.password,
      phonenumber: widget.phoneNumber,
      isMale: widget.isMale,
      username: widget.username,
    );
    res.then((value) {
      if (value == Errors.none) {
        showInfo(context, "Account created successfully!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else if (value == Errors.weakError) {
        showError(context, "The password provided is too weak.");
      } else if (value == Errors.matchError) {
        showError(context, "Passwords doesn't match");
      } else if (value == Errors.existsError) {
        showError(context, "The account already exists for that email.");
      } else {
        showError(context, "Failed to create account!");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  showError(context, error) {
    var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          error,
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showInfo(context, info) {
    var snackBar = SnackBar(
        content: Text(
      info,
      textAlign: TextAlign.center,
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
    AuthHelper auth = Provider.of<AuthHelper>(context);

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
                                      send(auth);
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
