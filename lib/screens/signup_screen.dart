import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/login_screen.dart';
import 'package:fantasyapp/screens/pages/create_team_page.dart';
import 'package:fantasyapp/vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController teamNameController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool obscure = true;
  showError(context, error) {
    var snackBar = SnackBar(
        backgroundColor: kPlayerCardColorPrimary,
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
  send(auth) async {
    FocusScope.of(context).unfocus();
    auth.attemptSignUp(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      teamName: teamNameController.text,
      confirm: passwordConfirmController.text,
    ).then((value){
      var formdata = formstate.currentState;
      if (formdata!.validate()) {
        formdata.save();

    if (value == Errors.none) {
      // print('yeeessss');
      // ignore: use_build_context_synchronously
      showInfo(context, "Account created successfully!");
       Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateTeamView()));
      
      // return true;
    } else if (value == Errors.weakError) {
      // ignore: use_build_context_synchronously
      showError(context, "The password provided is too weak.");
    } 
    else if (value == Errors.confirmMatchError) {
      // ignore: use_build_context_synchronously
      showError(context, "Password and confirm password do not match");
    } 
    else if (value == Errors.existsError) {
      // ignore: use_build_context_synchronously
      showError(context, "The account already exists for that email.");
    } else {
      // ignore: use_build_context_synchronously
      showError(context, "Failed to create account!");
    }
      }    
    // return false;
  
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthHelper auth = 
                                            Provider.of<AuthHelper>(context,
                                                listen: false);
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
                            child: 
                            Form(
          key: formstate,
                          child:  Column(
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
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        validator: (text) {
                  if (text!.isEmpty) {
                    return "Please Enter a valid Username";
                  }
                  return null;
                },
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
                                      child: TextFormField(
                                        validator: (text) {
                  if (text!.isEmpty) {
                    return "Please Enter a valid Team Name";
                  }
                  return null;
                },
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
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
                                          hintText: 'Team name',
                                          prefixIcon: Icon(Icons.people,
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
                                      child: TextFormField(
                                        validator: (text) {
                  RegExp regex =
                      RegExp("^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})+");
                  if (text!.isEmpty || !regex.hasMatch(text)) {
                    return "Please Enter a valid Email";
                  }
                  return null;
                },
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
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextFormField(
                                        validator: (text) {
                  RegExp regex =
                      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                  if (text!.isEmpty || text.length < 8) {
                    return "Please Enter a valid password over 8 characters";
                  }
                  if (!regex.hasMatch(text)) {
                    // || !text.contains(RegExp("r'[A-Z]+").toString()) || !text.contains(RegExp("r'[1-9]+").toString())) {
                    return "Password should contains  at least one upper case, one lower case and one digit ";
                  }
                  return null;
                },
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
                                      child: TextFormField(
                                        validator: (text) {
                  RegExp regex =
                      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                  if (text!.isEmpty || text.length < 8) {
                    return "Please Enter a valid password over 8 characters";
                  }
                  if (!regex.hasMatch(text)) {
                    // || !text.contains(RegExp("r'[A-Z]+").toString()) || !text.contains(RegExp("r'[1-9]+").toString())) {
                    return "Password should contains  at least one upper case, one lower case and one digit ";
                  }
                  return null;
                },
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
                                      onPressed: () async{
                                        
                                              send(auth);
                                        // verify(auth).then((value) {
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               CreateTeamView()));
                                        // });
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
                          ))))
                ])));
  }
}
