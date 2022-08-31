import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: (() => Navigator.pop(context)),
        ),
      ),
      body: Center(
        child: Column(
          children: const [
            Text(
              'Landing page',
            ),
          ],
        ),
      ),
    );
  }
}
