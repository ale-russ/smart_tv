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
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w700),
          ),
          Text('abbee', style: GoogleFonts.roboto(color: Colors.white)
              // TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.w400,
              //      ),
              ),
          Text(
            '+',
            style: TextStyle(
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
