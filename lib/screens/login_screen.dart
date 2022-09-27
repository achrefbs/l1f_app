import 'package:fantasyapp/providers/auth.dart';
import 'package:fantasyapp/screens/home_screen.dart';
import 'package:fantasyapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool obscure = true;

  send(AuthHelper auth) {
    FocusScope.of(context).unfocus();
    auth
        .attemptLogin(emailController.text, passwordController.text)
        .then((value) {
      if (value == Errors.none) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else if (value == Errors.wrongError) {
        showError(context, "Wrong email or password");
      } else if (value == Errors.noUserError) {
        showError(context, "No User!");
      } else {
        showError(context, "Failed to login!");
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
              'Login',
              textAlign: TextAlign.center,
            ),
            Column(children: [
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
              ElevatedButton(
                onPressed: () {
                  send(auth);
                },
                child: const Text('Login'),
              ),
            ]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
