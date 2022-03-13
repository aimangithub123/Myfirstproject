import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:the_kidz/controller/DataController.dart';


class ScholarView extends StatefulWidget {
  const ScholarView({Key? key}) : super(key: key);

  @override
  State<ScholarView> createState() => _ScholarViewState();
}

class _ScholarViewState extends State<ScholarView> {

  var bio;
  List<dynamic> bioList = [];

  @override
  Widget build(BuildContext context) {

    String scholarId = Get.arguments[Get.arguments.length -1];
    // DataController dataController = DataController();
    print(scholarId);
    var description;

    CollectionReference islamic = FirebaseFirestore.instance.collection("islamic scholar");
    final TextEditingController searchController = TextEditingController();
    QuerySnapshot snapshotData;
    return Scaffold(
      appBar: AppBar(
          title: Text(scholarId),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/bg2.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: FutureBuilder(
                future: islamic.doc(scholarId).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(!snapshot.hasData){
                    return const CircularProgressIndicator();
                    }
                  try {
                    Map<String, dynamic> data = snapshot.data!.data() as
                    Map<String, dynamic>;
                    String des = data["Description"];
                    var bio = data["Biography"];
                    var discontri = data["Discoveries and contributions"];
                    var fact = data["Facts"];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Text("DESCRIPTION: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 15,),

                          Text(des, style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                              fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                          const SizedBox(height: 40,),

                          const Text("BIOGRAPHY: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 15,),

                          Text("${bio[0]}\n\n ${bio[1]}\n\n${bio[2]}", style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                              fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                          const SizedBox(height: 15,),

                          const SizedBox(height: 35,),
                          const Text("DISCOVERIES AND CONTRIBUTIONS: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center),
                          const SizedBox(height: 15,),
                          Text("${discontri[0]}\n\n ${discontri[1]}\n\n${discontri[2]}", style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                              fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),

                          const SizedBox(height: 35,),
                          const Text("FACTS: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 15,),
                          Text("${fact[0]}\n\n ${fact[1]}\n\n${fact[2]}", style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                              fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),






                        ],

                      ),
                    );
                  } catch(e){
                    print(e);
                    return const CircularProgressIndicator();

                  }


                },
            ),
        ) ,
      ) /* add child content here */,
    );

  }
}

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('clients')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}



