import 'dart:io';
import 'package:flutter/material.dart';

class SetResourceName{
  SetResourceName({required String resourceName}) {
    final dir = Directory.current;
    String path = dir.path;
    path = path.replaceAll("\\", "\\\\");
    File file = new File(path + "\\lib\\Steganography\\script.py");
    List<String> contents = file.readAsLinesSync();
    contents[45] =
        "        path = str(pathlib.Path(\"$resourceName\").absolute())";
    file.writeAsStringSync(contents.join("\n"));
  }
}