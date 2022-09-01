import 'dart:ui';

import 'package:flutter/material.dart';

class Land extends StatelessWidget {
  const Land({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('landing page'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Bosque.jpg'),
                fit: BoxFit.fill)),
        child: Center(
            child: Text(
          'This is landing page',
          style: TextStyle(fontSize: 50, color: Colors.white),
          textAlign: TextAlign.left,
        )),
      ),
    );
  }
}
