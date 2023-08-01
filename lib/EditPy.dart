import 'dart:io';

import 'package:flutter/material.dart';

class EditPy {
  String line = "    ip_list=[";
  List<String> IPs = [];
  EditPy({
    required List<String> IPs,
  }) {
    this.IPs = IPs;
    IPs.forEach((element) {
      line += "\"${element}\", ";
    });
    line += "]";
    final dir = Directory.current;
    String path = dir.path;
    path = path.replaceAll("\\", "\\\\");
    File file = new File(path + "\\lib\\Steganography\\script.py");
    List<String> contents = file.readAsLinesSync();
    contents[41] = line;
    file.writeAsStringSync(contents.join("\n"));
  }
}
