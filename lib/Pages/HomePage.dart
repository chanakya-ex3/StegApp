import 'package:flutter/material.dart';
import 'package:isaa_app/EditPy.dart';
import 'package:isaa_app/myRoutes.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  String data = "";
  List<String> iplist = [];

  void textclear() {
    myController.clear();
  }
  void deleteContents(Directory directory) {
  if (directory.existsSync()) {
    directory.listSync().forEach((entity) {
      if (entity is File) {
        entity.deleteSync();
        print('Deleted file: ${entity.path}');
      } else if (entity is Directory) {
        deleteContents(entity);
        entity.deleteSync();
        print('Deleted subdirectory: ${entity.path}');
      }
    });
  }
}
  void goNext() async {
    final dir = Directory.current;
    String path = dir.path;
    path = path.replaceAll("\\", "\\\\");
    deleteContents(Directory(path+"\\ExecutableFolder"));
    EditPy(IPs: iplist);
    Navigator.pushNamed(context, MyRoutes.uploadPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Protect Data"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 300, vertical: 30),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: "Enter Intended IP Address",
                    border: OutlineInputBorder()),
                controller: myController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    data = myController.text;
                    iplist.add(data);
                  });
                  textclear();
                },
                child: Text("Add")),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Ip Address',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: iplist.map((e) {
                    return DataRow(cells: <DataCell>[
                      DataCell(Row(
                        children: [
                          Text(
                            e,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                              child: Text("Remove"),
                              onPressed: () {
                                setState(() {
                                  iplist.remove(e);
                                });
                              })
                        ],
                      )),
                    ]);
                  }).toList()),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => goNext(),
          child: Text("Save"),
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
