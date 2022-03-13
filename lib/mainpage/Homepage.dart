
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:the_kidz/controller/authController.dart';
import 'package:the_kidz/main.dart';
import 'package:the_kidz/menu/menu1.dart';
import 'package:the_kidz/menu/menu2.dart';
import 'package:the_kidz/menu/menu3.dart';
import 'package:the_kidz/menu/menu3.dart';

import '../navbar.dart';


class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);
  get child => Menu1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  NavBar(),
      appBar: AppBar(title: Text('TheKidz'),backgroundColor: Colors.deepPurple,),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/menubg1.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Menu',
                style: TextStyle(fontSize: 95, fontFamily: 'RampartOne'),
              ),
              SizedBox(height: 65),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      transitionsBuilder:
                      (context, animation, animationTime, child) {
                        animation = CurvedAnimation(
                            parent: animation, curve: Curves.bounceIn);
                        return ScaleTransition(
                          alignment: Alignment.center,
                          scale: animation,
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return Menu1();
                      }
                    )
                  );
                },
                child: Text(
                  'Stories of Islamic Scholars',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              SizedBox(height: 30),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  Get.to(Menu2(),
                      transition: Transition.cupertino,duration: Duration(seconds:1));
                },
                child: Text('Stories of 25 Prophets',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        fontFamily: 'VarelaRound',
                        fontWeight: FontWeight.bold)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),

              SizedBox(height: 30),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  Get.to(Menu3(),
                      transition: Transition.fade,duration: Duration(seconds:1));
                },
                child: Text('More',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        fontFamily: 'VarelaRound',
                        fontWeight: FontWeight.bold)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),

          ]),

        )  /* add child content here */,

      ),
    );
  }
}
