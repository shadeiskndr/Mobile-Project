import 'package:flutter/material.dart';
import 'package:mobile2/admin_area.dart';
import 'package:mobile2/admin_role.dart';
import 'package:mobile2/main.dart';
import 'package:mobile2/admin_registered_list.dart';

class MyDrawal extends StatelessWidget {
  const MyDrawal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 55),
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text(
                'Add Role',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AdminRolePage()));
              },
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Add Area',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AdminAreaPage()));
              },
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'App User List',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisteredList()));
              },
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeRoute()));
              },
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
