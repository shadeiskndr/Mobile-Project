import 'package:mobile2/login_user_details.dart';
import 'package:mobile2/main.dart';
import 'package:mobile2/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'db_manager.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({Key? key}) : super(key: key);
  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () {
                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeRoute()),
                );
              },
            ),
          ],
          title: Text(
            "Registration Form",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Form(
                key: _loginKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                        'Welcome, please fill in the login form',
                        style: CarRentalTheme.darkTextTheme.displaySmall,
                      ),
                    ),
                    TextFormField(
                      style: CarRentalTheme.lightTextTheme.labelLarge,
                      decoration: InputDecoration(
                          hintStyle: CarRentalTheme.lightTextTheme.labelMedium,
                          filled: true,
                          fillColor: Colors.blue[50],
                          prefixIcon: const Icon(Icons.email_outlined,
                              color: Colors.blue),
                          hintText: 'Email',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Please enter your email';
                        } else if (!EmailValidator.validate(email)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: false,
                      style: CarRentalTheme.lightTextTheme.labelLarge,
                      decoration: InputDecoration(
                          hintStyle: CarRentalTheme.lightTextTheme.labelMedium,
                          filled: true,
                          fillColor: Colors.blue[50],
                          prefixIcon: const Icon(Icons.email_outlined,
                              color: Colors.blue),
                          hintText: 'Password',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_loginKey.currentState!.validate()) {
                          _loginCheck();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  void _loginCheck() async {
    final successLogIn = await dbHelper.checkLogin(
        emailController.text, passwordController.text);
    if (successLogIn) {
      final userLoginID = await dbHelper.getLoggedInUserID(
          emailController.text, passwordController.text);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              title: const Text('Login Successful'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LoginUserDetails(userLoginID: userLoginID),
                      )),
                  child: const Text('OK'),
                ),
              ]);
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              title: const Text('Login Failed'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const UserLoginPage(),
                      )),
                  child: const Text('OK'),
                ),
              ]);
        },
      );
    }
  }
}
