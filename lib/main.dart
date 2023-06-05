import 'package:flutter/material.dart';
import 'package:mobile2/admin_role.dart';
import 'package:mobile2/loginpage.dart';
import 'package:mobile2/registerpage.dart';
import 'package:mobile2/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = CarRentalTheme.dark();
    return (MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeRoute(),
        '/second': (context) => const AdminRolePage(),
        '/third': (context) => const RegistrationForm(),
        '/fourth': (context) => const UserLoginPage(),
      },
    ));
  }
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 2.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'EasyConference',
                  style: CarRentalTheme.darkTextTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/third');
                        },
                        child: const Text('Register')),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/fourth');
                        },
                        child: const Text('Login')),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/second');
                        },
                        child: const Text('Admin Login (Not Finished)')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
