import 'package:flutter/material.dart';
import 'package:isaa_app/Pages/HomePage.dart';
import 'package:isaa_app/Pages/UploadPage.dart';
import 'package:isaa_app/myRoutes.dart';
import 'dart:io';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {MyRoutes.uploadPage: (context) => UploadPage()},
    );
  }
}
