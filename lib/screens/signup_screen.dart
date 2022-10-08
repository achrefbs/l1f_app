import 'package:fantasyapp/screens/login_screen.dart';
import 'package:fantasyapp/screens/pages/create_team_page.dart';
import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool obscure = true;

  verify() {
    if (passwordController.text == passwordConfirmController.text) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => CreateTeamView(
                email: emailController.text,
                password: passwordController.text,
                username: usernameController.text,
              )),
        ),
      );
      return true;
    } else {
      return false;
    }
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

  @override
  Widget build(BuildContext context) {
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
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        controller: usernameController,
                                        decoration: const InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          hintText: 'Username',
                                          prefixIcon: Icon(Icons.person,
                                              color: kPlayerCardColorPrimary),
                                        ),
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          hintText: 'Email',
                                          prefixIcon: Icon(Icons.email,
                                              color: kPlayerCardColorPrimary),
                                        ),
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        controller: passwordController,
                                        obscureText: obscure,
                                        decoration: InputDecoration(
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          hintText: 'Password',
                                          prefixIcon: const Icon(Icons.lock,
                                              color: kPlayerCardColorPrimary),
                                          suffixIcon: IconButton(
                                            color: kPlayerCardColorPrimary,
                                            icon: Icon(obscure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                obscure = !obscure;
                                              });
                                            },
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        controller: passwordConfirmController,
                                        obscureText: obscure,
                                        decoration: InputDecoration(
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPlayerCardColorPrimary),
                                          ),
                                          hintText: 'Confirm Password',
                                          prefixIcon: const Icon(Icons.lock,
                                              color: kPlayerCardColorPrimary),
                                          suffixIcon: IconButton(
                                            color: kPlayerCardColorPrimary,
                                            icon: Icon(obscure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                obscure = !obscure;
                                              });
                                            },
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        verify();
                                      },
                                      child: const Text(
                                        'Next',
                                        style: TextStyle(
                                            color: kTransparentBackgroundColor,
                                            fontWeight: FontWeight.bold),
                                      ),
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
