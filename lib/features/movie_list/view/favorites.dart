import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FocusableActionDetector(
            child: ElevatedButton(
      onPressed: () => {},
      child: const Text("testing"),
    )));
  }
}
