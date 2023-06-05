import 'package:flutter/material.dart';
import 'db_manager.dart';

class RegisteredList extends StatefulWidget {
  const RegisteredList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisteredListState createState() => _RegisteredListState();
}

class _RegisteredListState extends State<RegisteredList> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allUserData = [];

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Presenter List"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Text(""),
            Expanded(
                child: ListView.builder(
              itemCount: allUserData.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                var item = allUserData[index];
                return Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text("${item['name']}"),
                          const SizedBox(width: 5),
                          Text("${item['role']}"),
                          const Spacer(),
                          const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _delete(item['id']);
                            },
                            icon: const Icon(Icons.delete),
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
            ))
          ],
        ),
      ),
    );
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRowsofUser();
    print('query all rows:');
    allRows.forEach(print);
    allUserData = allRows;
    setState(() {});
  }

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    _query();
  }
}
