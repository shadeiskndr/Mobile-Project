// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile2/mydrawal.dart';
import 'db_manager.dart';

class AdminAreaPage extends StatefulWidget {
  const AdminAreaPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminAreaPageState createState() => _AdminAreaPageState();
}

class _AdminAreaPageState extends State<AdminAreaPage> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allAreaData = [];
  TextEditingController areaNameController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: MyDrawal(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Specialization Area"),
      ),
      body: Form(
        key: formGlobalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              hintText: 'Add Specialization Area',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            controller: areaNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter role name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          _insert();
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allAreaData.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, index) {
                          var item = allAreaData[index];
                          return Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("${item['areaName']}"),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        _delete(item['id']);
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {'areaName': areaNameController.text};
    print('insert stRT');

    final id = await dbHelper.insertArea(row);
    if (kDebugMode) {
      print('inserted row id: $id');
    }
    areaNameController.text = "";
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRowsofArea();
    print('query all rows:');
    allRows.forEach(print);
    allAreaData = allRows;
    setState(() {});
  }

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.deleteArea(id);
    print('deleted $rowsDeleted row(s): row $id');
    _query();
  }
}
