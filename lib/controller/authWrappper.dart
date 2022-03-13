
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_kidz/mainpage/Homepage.dart';
import 'package:the_kidz/mainpage/LoginPage.dart';

import 'authController.dart';


class AuthWrapper extends GetWidget<AuthController> {

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().user != null) ? Homepage() : LoginPage();
    });
  }
}



