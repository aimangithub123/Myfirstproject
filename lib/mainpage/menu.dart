import 'package:flutter/material.dart';


class TheKidz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/more_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
       ),
      )
    );
  }
}