import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
       
      ),
      body: Center(
        child: Text(
            'Please select a convenient payment method to make subscrition and play all movies',
            style: TextStyle(color: Colors.black,fontSize:30,),
            ),
      ),
    );
  }
}
