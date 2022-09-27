import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController teamNameController = TextEditingController();

  bool obscure = true;

  send(AuthHelper auth) {
    FocusScope.of(context).unfocus();
    var res = auth.attemptSignUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      passwordConfirmation: passwordConfirmController.text.trim(),
      fullname: fullnameController.text.trim(),
      phonenumber: phoneNumberController.text.trim(),
      username: usernameController.text.trim(),
      teamName: teamNameController.text.trim(),
      isMale: true,
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

  @override
  Widget build(BuildContext context) {
    AuthHelper auth = Provider.of<AuthHelper>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text(
              'Sign up',
              textAlign: TextAlign.center,
            ),
            Column(children: [
              TextField(
                controller: fullnameController,
                decoration: const InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextField(
                controller: teamNameController,
                decoration: const InputDecoration(
                  hintText: 'team name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextField(
                controller: passwordController,
                obscureText: obscure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon:
                        Icon(obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextField(
                controller: passwordConfirmController,
                obscureText: obscure,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon:
                        Icon(obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              ElevatedButton(
                onPressed: () {
                  send(auth);
                },
                child: const Text('Sign Up'),
              ),
            ]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
