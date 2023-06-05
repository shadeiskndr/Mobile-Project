import 'package:flutter/material.dart';
import 'package:mobile2/loginpage.dart';
import 'db_manager.dart';

// ignore: must_be_immutable
class LoginUserDetails extends StatefulWidget {
  int userLoginID;
  LoginUserDetails({Key? key, required this.userLoginID}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginUserDetailsState createState() => _LoginUserDetailsState();
}

class _LoginUserDetailsState extends State<LoginUserDetails> {
  List<Map<String, dynamic>> details = [];
  bool isLoading = false;
  // This function is used to fetch all data from the database
  Future _refreshUserDetails() async {
    setState(() => isLoading = true);
    details =
        await DatabaseHelper.instance.queryOneUserDetails(widget.userLoginID);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _refreshUserDetails();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showForm() async {
    final existingUser =
        details.firstWhere((element) => element['id'] == widget.userLoginID);
    nameController.text = existingUser['name'];
    emailController.text = existingUser['email'];
    phoneController.text = existingUser['phone'].toString();
    roleController.text = existingUser['role'];
    areaController.text = existingUser['area'];
    instituteController.text = existingUser['institute'];
    passwordController.text = existingUser['password'];

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  // this will prevent the soft keyboard from covering the text fields
                  bottom: MediaQuery.of(context).viewInsets.bottom + 120,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Name'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(hintText: 'Telephone'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: roleController,
                      decoration: const InputDecoration(hintText: 'Role'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: areaController,
                      decoration: const InputDecoration(
                          hintText: 'Specialization Area'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: instituteController,
                      decoration: const InputDecoration(hintText: 'Institute'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _updateItem(widget.userLoginID);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Update'),
                    )
                  ],
                ),
              ),
            ));
  }

  Future<void> _updateItem(int id) async {
    await DatabaseHelper.updateUserDetails(
        id,
        nameController.text,
        emailController.text,
        int.parse(phoneController.text),
        roleController.text,
        areaController.text,
        instituteController.text,
        passwordController.text);
    _refreshUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    final existingUser =
        details.firstWhere((element) => element['id'] == widget.userLoginID);
    nameController.text = existingUser['name'];
    emailController.text = existingUser['email'];
    phoneController.text = existingUser['phone'].toString();
    roleController.text = existingUser['role'];
    areaController.text = existingUser['area'];
    instituteController.text = existingUser['institute'];
    passwordController.text = existingUser['password'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserLoginPage()),
                );
              },
            ),
          ],
          title: const Text('Registered User Details'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 800,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textfield(
                                  controller: nameController,
                                  hintText: nameController.text),
                              textfield(
                                  controller: emailController,
                                  hintText: emailController.text),
                              textfield(
                                  controller: passwordController,
                                  hintText: passwordController.text),
                              textfield(
                                  controller: phoneController,
                                  hintText: phoneController.text),
                              textfield(
                                  controller: roleController,
                                  hintText: roleController.text),
                              textfield(
                                  controller: areaController,
                                  hintText: areaController.text),
                              textfield(
                                  controller: instituteController,
                                  hintText: instituteController.text),
                              SizedBox(
                                height: 55,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _showForm(),
                                  child: const Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget textfield({@required hintText, @required controller}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        enabled: false,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
