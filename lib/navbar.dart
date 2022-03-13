import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:the_kidz/view/favouritesview.dart';
import 'controller/authController.dart';

class NavBar extends GetWidget<AuthController> {
  const NavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 30, 30, 0),
        children: [
          const UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage("assets/image/mylogo.gif"),
               fit: BoxFit.cover,
            )
          ), accountEmail: null, accountName: null,
          ),
          ListTile(
                  leading: const Icon(Icons.favorite,color: Colors.deepPurple),
                  title: const Text('Favorites',style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold),),
                  onTap: () => Get.to(const FavouritesView(),
                  transition: Transition.fadeIn,duration: const Duration(seconds: 2) ),
                ),
          ListTile(
            leading: const Icon(Icons.exit_to_app,color: Colors.deepPurple),
            title: const Text('Sign Out', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold)),
          onTap: () => { AuthController().signOut(),
            },
          ),
            ],
          ),
      );
  }
}




