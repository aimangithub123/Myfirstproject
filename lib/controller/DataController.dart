// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
//
//
// class DataController extends GetxController {
//   Future getData(String collection, String id) async {
//     final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
//     return snapshot.docs;
//   }
// }
//
//
// Future queryData(String queryString, String id) async {
//   return FirebaseFirestore.instance.collection("islamic scholar").where(
//     "Biography", isGreaterThanOrEqualTo: queryString
//   ).get();
// }
//
//
//
//
// //CollectionReference islamic = FirebaseFirestore.instance.collection("islamic scholar");
// //islamic.doc(scholarId).get();