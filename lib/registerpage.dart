import 'package:flutter/foundation.dart';
import 'package:mobile2/theme.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mobile2/main.dart';
import 'db_manager.dart';
import 'package:mobile2/admin_registered_list.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();
  final areaController = TextEditingController();
  final instituteController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String currentRole = "";
  String currentArea = "";
  List<String> allRoleData = [];
  List<String> allAreaData = [];
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _queryRole();
    _queryArea();
  }

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
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          'Welcome, please fill in the registration form',
                          style: CarRentalTheme.darkTextTheme.displaySmall,
                        ),
                      ),
                      TextFormField(
                        style: CarRentalTheme.lightTextTheme.labelLarge,
                        decoration: InputDecoration(
                            hintStyle:
                                CarRentalTheme.lightTextTheme.labelMedium,
                            filled: true,
                            fillColor: Colors.blue[50],
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.blue),
                            hintText: 'Name',
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: nameController,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: CarRentalTheme.lightTextTheme.labelLarge,
                        decoration: InputDecoration(
                            hintStyle:
                                CarRentalTheme.lightTextTheme.labelMedium,
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
                            hintStyle:
                                CarRentalTheme.lightTextTheme.labelMedium,
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
                      TextFormField(
                        style: CarRentalTheme.lightTextTheme.labelLarge,
                        decoration: InputDecoration(
                            hintStyle:
                                CarRentalTheme.lightTextTheme.labelMedium,
                            filled: true,
                            fillColor: Colors.blue[50],
                            prefixIcon: const Icon(Icons.phone_android_outlined,
                                color: Colors.blue),
                            hintText: 'Telephone No.',
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your telephone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: allRoleData.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (selectedItem) => setState(() {
                              currentRole = selectedItem!;
                            }),
                            hint: const Text("Select Role"),
                            value: currentRole.isEmpty ? null : currentRole,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: allAreaData.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (selectedItem) => setState(() {
                              currentArea = selectedItem!;
                            }),
                            hint: const Text("Select Specialization Area"),
                            value: currentArea.isEmpty ? null : currentArea,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: CarRentalTheme.lightTextTheme.labelLarge,
                        decoration: InputDecoration(
                            hintStyle:
                                CarRentalTheme.lightTextTheme.labelMedium,
                            filled: true,
                            fillColor: Colors.blue[50],
                            prefixIcon: const Icon(Icons.house_outlined,
                                color: Colors.blue),
                            hintText: 'Institute',
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your institute';
                          }
                          return null;
                        },
                        controller: instituteController,
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    _insert();
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'User registration form has been submitted.')),
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            // Retrieve the text the that user has entered by using the
                            // TextEditingController.
                            title: const Text('User Registration'),
                            content: SizedBox(
                                width: double.maxFinite,
                                child: ListView(shrinkWrap: true, children: [
                                  Text(nameController.text),
                                  Text(emailController.text),
                                  Text(phoneController.text),
                                  Text(instituteController.text),
                                  Text(passwordController.text)
                                ])),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ]);
                      },
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'role': currentRole,
      'area': currentArea,
      'institute': instituteController.text,
      'password': passwordController.text,
    };
    print('insert stRT');
    currentRole = "";
    currentArea = "";

    final id = await dbHelper.insertUser(row);
    if (kDebugMode) {
      print('inserted row id: $id');
    }
    _queryRole();
    _queryArea();
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisteredList()));
  }

  void _queryRole() async {
    final allRows = await dbHelper.queryAllRowsofRole();
    if (kDebugMode) {
      print('query all rows:');
    }
    for (var element in allRows) {
      allRoleData.add(element["roleName"]);
    }
    setState(() {});
  }

  void _queryArea() async {
    final allRows = await dbHelper.queryAllRowsofArea();
    if (kDebugMode) {
      print('query all rows:');
    }
    for (var element in allRows) {
      allAreaData.add(element["areaName"]);
    }
    setState(() {});
  }
}
