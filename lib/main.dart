// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:rick_and_morty/ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          fontFamily: "Georgia",
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline2: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              headline3: TextStyle(fontSize: 24.0, color: Colors.white),
              bodyText2: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              bodyText1: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.white),
              caption: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey))),
      home: HomePage(title: 'Rick adn Morty'),
    );
  }
}

//(3) next https://www.youtube.com/watch?v=BUisJjqix60&ab_channel=KonstantinKokorin