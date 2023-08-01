import 'dart:io';

import 'package:flutter/material.dart';

class CreateExe {
  CreateExe() {
    driverfunc();
  }
  void driverfunc() async {
    final dir = Directory.current;
    String path = dir.path;
    path = path.replaceAll("\\", "\\\\");
    String pyFile = path + "\\lib\\Steganography\\script.py";
    String OutputPath = path + "\\ExecutableFolder";
    String exeFile = await Process.run('pyinstaller', ['-F', pyFile],
            workingDirectory: OutputPath)
        .toString();
    print('The executable file has been created at: $exeFile');
  }
}
