import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../vars.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late Image image1;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obscure = true;
  @override
  void initState() {
    super.initState();
    image1 = Image.asset("images/background.jpg");
  }

  @override
  void didChangeDependencies() {
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }

  send(AuthHelper auth) {
    FocusScope.of(context).unfocus();
    auth
        .attemptLogin(emailController.text.trim(), passwordController.text.trim())
        .then((value) {
      // if (value == Errors.none && value.toString().isNotEmpty) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomeScreen(),
      //     ),
      //   );
      // }
      var formdata = formstate.currentState;
      if (formdata!.validate()) {
        formdata.save();
      if
      (value == Errors.wrongError) {
        showError(context, "Wrong email or password");
      } else if (value == Errors.noUserError) {
        showError(context, "No user found for that email!!");
      } else if (value == Errors.none){ 
      showError(context, "Logged in successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
        else {
        showError(context, "Something went wrong");
        }
      } 
    });
  }
   

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

  @override
  Widget build(BuildContext context) {
    AuthHelper auth = Provider.of<AuthHelper>(context);
    return 
    // MaterialApp(
        // theme: ThemeData(
        //   inputDecorationTheme: const InputDecorationTheme(
        //     enabledBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(color: kPlayerCardColorPrimary),
        //     ),
        //     focusedBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(color: kPlayerCardColorPrimary),
        //     ),
        //   ),
        // ),
        // home: 
        Scaffold(
            body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image1.image,
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
                        child: Form(
                key: formstate,
                child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
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
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: 'Email',
                                    
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPlayerCardColorPrimary),
            ),
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    prefixIcon: Icon(Icons.email,
                                        color: kPlayerCardColorPrimary),
                                  ),
                                )),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                          
                                  validator: (text) {
                          RegExp regex =
                              RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])');
                          if (text!.isEmpty || text.length < 6 ||!regex.hasMatch(text)) {
                            return "Please enter a valid Password";
                          }
                          return null;
                        },
                        
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  obscureText: obscure,
                                  decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPlayerCardColorPrimary),
            ),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: kPlayerCardColorPrimary,
                                    ),
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
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  send(auth);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: kTransparentBackgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            // SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kTransparentBackgroundColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text('Sign up',
                                      style: TextStyle(
                                          color: kPlayerCardColorPrimary)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ))
              ]),
        )
        // )
        );
  }
}
