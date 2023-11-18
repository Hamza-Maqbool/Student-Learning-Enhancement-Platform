import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/home.dart';
import 'package:studentlearningenhancement/pages/loginPage.dart';
import 'package:studentlearningenhancement/pages/createCoursePage.dart';
import 'package:studentlearningenhancement/pages/signUpPage.dart';

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
