// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/create_notification.dart';
import 'package:maintenance/update_notification.dart';
import 'login_screen.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/createnotification': (context) => CreateNotification(),
        '/updatenotification': (context) => UpdateNotification(),
      },
      // home: LoginScreen(),
      home: LoginScreen(),
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        accentColor: Color(0xFF0C1B2D),
        bottomAppBarColor: Color(0xFF0A0E21),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0A0E21),
          selectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
