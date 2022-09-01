import 'package:flutter/material.dart';
import 'package:sams_tv/land_tv.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('you sucessfully pass login page'),
      ),
      body: Container(
        // color: Colors.green,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'This is landing page',
                style: TextStyle(fontSize: 40),
                //textAlign: TextAlign.start,
              ),
              Image.asset(
                "assets/images/Batman_ The Animated Series, an art print by Rafael Grassetti.jpg",
                height: 600,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Land()),
                  );
                },
                child: Text('click here'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
