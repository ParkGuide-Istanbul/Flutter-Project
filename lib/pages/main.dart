import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/pages/login.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors.darkPurple() as MaterialColor,
      ),
      home: LoginPage(),
    );
  }
}
