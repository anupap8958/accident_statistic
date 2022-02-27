import 'package:accident_statistic/pages/accidentList_month.dart';
import 'package:accident_statistic/pages/accidentDetail_month.dart';
import 'package:accident_statistic/pages/home_page.dart';
import 'package:accident_statistic/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Refresh(),
      routes: {
        HomePage.routeName : (context) => const HomePage(),
        ListMonth.routeName : (context) => const ListMonth(),
        AccidentDetailMonth.routeName : (context) => const AccidentDetailMonth(),
      },
      // initialRoute: HomePage.routeName,
    );
  }
}