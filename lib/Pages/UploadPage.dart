import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:isaa_app/CreateExe.dart';
import 'package:isaa_app/EditPy.dart';
import 'package:isaa_app/SetResourceName.dart';
import 'dart:io';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  FilePickerResult? result;
  String? _fileName = "";
  PlatformFile? pickedfile;
  bool isLoading = false;
  bool isSelected = false;
  String? fpath = "";

  String? prompt(String message) {
  print(message);
  String? response = stdin.readLineSync();
  return response;
}
  Future<bool> copyFile(String sourcePath, String destinationPath) async {
    if (!File(sourcePath).existsSync()) {
      throw Exception('Source file does not exist');
    }
    await File(sourcePath).copySync(destinationPath);
    return true;
  }

  void goNext(filename, filepath) async {
    final dir = Directory.current;
    String path = dir.path;
    path = path.replaceAll("\\", "\\\\");
    String desination = path + "\\ExecutableFolder\\$filename";
    print("dwd" + filepath);
    print("dwd" + desination);
    bool success = await copyFile(filepath, desination);
    if (success) {
      print('File copied successfully');
    } else {
      print('File copy failed');
    }
    SetResourceName(resourceName: filename);
    CreateExe();
  }

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fpath = result!.files.first.path;
        isSelected = true;

        print("File Name:$_fileName");
        print("File Path:$fpath");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Drag and Drop'),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Select File to be protected",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    Center(
                      child: TextButton(
                        style: ButtonStyle(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.select_all_rounded,
                                size: 80, color: Colors.white),
                            Text(
                              "Select File Here",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ],
                        ),
                        onPressed: () => pickFile(),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: isSelected
                    ? ListTile(
                        leading: Icon(Icons.file_upload_rounded),
                        title: Text(
                          "$_fileName",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    : Text("No File Selected")),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: isSelected
              ? () => goNext(_fileName, fpath)
              : () => print("No File Selected"),
          child: Text("Protect"),
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
