import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class DuaView extends StatefulWidget {
  const DuaView({Key? key}) : super(key: key);

  @override
  State<DuaView> createState() => _DuaViewState();
}

class _DuaViewState extends State<DuaView> {

  var dua;
  List<dynamic> duaList = [];

  @override
  Widget build(BuildContext context) {

    String duaId = Get.arguments[Get.arguments.length -1];
    print(duaId);
    var description;

    // final Stream<QuerySnapshot> details = FirebaseFirestore.instance.collection("islamic scholar").snapshots();
    CollectionReference duas = FirebaseFirestore.instance.collection("daily duas");

    return Scaffold(
      appBar: AppBar(

        title: Text(duaId),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/bggif2.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(

          child: FutureBuilder(
            future: duas.doc(duaId).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if(!snapshot.hasData){
                return const CircularProgressIndicator();
              }
              try {
                Map<String, dynamic> data = snapshot.data!.data() as
                Map<String, dynamic>;

                String dua = data["Dua"];
                var src = data["Source"];
                var trs = data["Translation"];
                // var fact = data["Facts"];

                //start below
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text("Dua: ", style: const TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center),
                      SizedBox(height: 15,),

                      Text(dua, style: TextStyle(fontSize: 30,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.center),
                      SizedBox(height: 40,),

                      Text("Translation: ", style: const TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 15,),

                      Text(trs, style: TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      SizedBox(height: 40,),
                      Text("Source: ", style: const TextStyle(fontSize: 30,fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 15,),

                      Text(src, style: TextStyle(fontSize: 20,fontFamily: 'Comfortaa',color: Colors.black,
                          fontWeight: FontWeight.w700),textAlign: TextAlign.justify,),
                      SizedBox(height: 40,),


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






