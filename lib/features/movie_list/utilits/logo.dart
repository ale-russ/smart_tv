import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Text(
            'K',
            style: GoogleFonts.roboto(
              color: Color.fromRGBO(255, 165, 0, 1),
              fontSize: 17,
            ),
          ),
          Text('abbee',
              style: GoogleFonts.roboto(
                  color: Color.fromRGBO(255, 255, 255, 1), fontSize: 17)),
          Text(
            '+',
            style: TextStyle(color: Colors.amber, fontSize: 17),
          )
        ],
      ),
    );
  }
}
