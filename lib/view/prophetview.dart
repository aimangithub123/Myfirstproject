import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:firestore_search/firestore_search.dart';


class ProphetView extends StatefulWidget {
  const ProphetView({Key? key}) : super(key: key);

  @override
  State<ProphetView> createState() => _ProphetViewState();
}

class _ProphetViewState extends State<ProphetView> {
  var name;
  List<dynamic> bioList = [];

  @override
  Widget build(BuildContext context) {
    String prophetId = Get.arguments[Get.arguments.length - 1];
    print(prophetId);
    var name;


    CollectionReference prophet = FirebaseFirestore.instance.collection("prophet");
    return Scaffold(
      appBar: AppBar(
        title: Text(prophetId),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/bggif.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: prophet.doc(prophetId).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              try {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                String name = data["Name"];
                var age = data["Age"];
                var placeofdeath = data["Place of death"];
                var theperiodofhistory = data["The period of history"];
                var locationelected = data["Location elected as a Prophet"];
                var nameofindividuals = data["Name of individuals (Kaum)"];
                var totalnumber = data["Total number of ancestries"];
                var placeofdescent = data["Place of descent on earth"];
                var summary = data["Summary of biography"];
                //start below
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(

                    children: [
                      const Text("Name: ",
                          style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',fontWeight: FontWeight.bold,
                          color: Colors.white),textAlign: TextAlign.justify),
                      SizedBox(height: 2),

                      Text(name, style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify),
                      SizedBox(height: 20,),

                      const Text("Age: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 2,),

                      Text(age, style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      SizedBox(height: 20,),

                      const Text("Place of death: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 2,),

                      Text(placeofdeath, style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      const SizedBox(height: 20,),

                      const Text("Place of descent on earth: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 2,),

                      Text(placeofdescent, style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      const SizedBox(height: 20,),

                      const Text("The period of history: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 2,),

                      Text(theperiodofhistory, style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      const SizedBox(height: 20,),

                      const Text("Location elected as a Prophet: ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
                      const SizedBox(height: 2,),

                      Text(locationelected, style: const TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      const SizedBox(height: 20,),

                      const Text("Name of individuals (Kaum): ", style: TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
                      const SizedBox(height: 2,),

                      Text(nameofindividuals, style: TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      SizedBox(height: 20,),

                      Text("Total number of ancestries: ", style: const TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
                      SizedBox(height: 2,),

                      Text(totalnumber, style: TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      SizedBox(height: 20,),

                      Text("Summary of biography: ", style: const TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.left,),
                      SizedBox(height: 2,),

                      Text(summary, style: TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      SizedBox(height: 20,),






                    ],
                  ),
                );
              } catch (e) {
                print(e);
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ) /* add child content here */,
    );
  }
}


