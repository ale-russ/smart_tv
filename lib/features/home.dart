import 'dart:html';

import 'package:flutter/material.dart';
import 'package:smart_tv/features/current_home.dart';
import 'package:smart_tv/features/favoraite.dart';
import 'NavigationDrawer.dart';
import 'chat.dart';
import 'news&hots.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final Screen = [
     CurrentPage (),
     Favorate (),
     Chat(),
     News()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        // ignore: prefer_const_constructors
        title: Text(
          'MOVIE LIST',
          textAlign: TextAlign.justify,
        ),
      ),
      // ignore: prefer_const_constructors
      body: Screen[currentIndex],
      
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'News&Hots',
            ),
          ]),
    );
  }
}
