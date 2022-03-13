import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/authBinding.dart';
import 'controller/authWrappper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  return runApp(TheKidz());
}

class TheKidz extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
        initialBinding: AuthBinding(),
        title: "TheKidz",
    );
  }
}





