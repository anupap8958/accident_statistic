import 'package:accident_statistic/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

class Refresh extends StatefulWidget {
  static const routeName = '/refresh';

  const Refresh({Key? key}) : super(key: key);

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomePage.routeName,
        title: Text(
          'Welcome',
          style: GoogleFonts.lato(
            color: Colors.white70,
            fontSize: 42.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        image: Image.asset('assets/images/missing-car.png'),
        backgroundColor: const Color(0xFF1900b3),
        styleTextUnderTheLoader: const TextStyle(color: Colors.deepPurple),
        photoSize: 150.0,
        loaderColor: Colors.white70);
  }
}
