import 'package:flutter/material.dart';

class LMovieLogo extends StatelessWidget {
  const LMovieLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "MOovie",
      style: TextStyle(color: Colors.red, fontSize: 26.0, fontWeight: FontWeight.bold),
    );
  }
}
