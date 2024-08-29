import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FavoritesScreen.dart';
import 'package:flutter_application_1/NewsScreen.dart';
import 'package:flutter_application_1/NewsDetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => NewsScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/newsDetail': (context) => NewsDetails(),
      },
    );
  }
}
