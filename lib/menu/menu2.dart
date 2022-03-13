// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_navigation/src/routes/transitions_type.dart';
// import 'package:the_kidz/view/prophetview.dart';
//
//
//
//
// class Menu2 extends StatefulWidget {
//   const Menu2({Key? key}) : super(key: key);
//
//   @override
//   State<Menu2> createState() => _Menu2State();
// }
//
// class _Menu2State extends State<Menu2> {
//   @override
//
//   Widget build(BuildContext context) {
//
//     final Stream<QuerySnapshot> scholars = FirebaseFirestore.instance.collection("prophet").snapshots();
//
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         //leading: const Icon(Icons.menu),
//         title: const Text("Stories Of Prophets",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//             )),
//         actions: <Widget>[
//           Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Container(
//               width: 36,
//               height: 30,
//               decoration: BoxDecoration(
//                   color: Colors.grey[800],
//                   borderRadius: BorderRadius.circular(10)),
//               child: Center(child: Text("0")),
//             ),
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 height: 240,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: const DecorationImage(
//                         image: AssetImage('assets/image/scholarbg2.jpg'),
//                         fit: BoxFit.cover)),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       gradient:
//                       LinearGradient(begin: Alignment.bottomRight, colors: [
//                         Colors.black.withOpacity(.4),
//                         Colors.black.withOpacity(.2),
//                       ])),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: const <Widget>[
//                       Text(
//                         "Stories of Prophets",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold), textAlign: TextAlign.center,
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: StreamBuilder(
//                     stream: scholars,
//                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if(!snapshot.hasData){
//                         return const CircularProgressIndicator();
//                       }
//                       return GridView(
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 20,
//                             mainAxisSpacing: 20
//                         ),
//                         children: snapshot.data!.docs.map((prophet) {
//                           //Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//                           return GestureDetector(
//                             onTap: () {
//                               Get.to(() => const ProphetView(), arguments: [prophet.id],
//                                   transition: Transition.rightToLeftWithFade,duration: Duration(seconds: 2));
//                             },
//
//                             child: Container(
//
//                                 margin: EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30),
//                                     image: const DecorationImage(
//                                         image:
//                                         AssetImage(
//                                             'assets/image/dp.jpg'),
//                                         fit: BoxFit.cover)),
//                                 padding: const EdgeInsets.all(10),
//
//                                 child: Center(
//                                   child: Text(prophet.id,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white,
//                                           fontFamily: 'VarelaRound',
//                                           fontWeight: FontWeight.bold, )),
//
//                                 )),
//                           );
//                         }).toList(),
//
//                       );
//                     } ),)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_kidz/controller/string_extension.dart';
import 'package:the_kidz/view/prophetview.dart';


class Menu2 extends StatefulWidget {
  const Menu2({Key? key}) : super(key: key);

  @override
  State<Menu2> createState() => _Menu2State();
}

class _Menu2State extends State<Menu2> {

  TextEditingController searchController = new TextEditingController();

  String results = "";

  final box = GetStorage();

  isbook(String name){
    if(box.read(name)==true){
      setState(() {
        box.write(name, false);
      });
    } else {
      setState(() {
        box.write(name, true);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(onSearchChanged);
  }

  onSearchChanged() {
    setState(() {
      results = searchController.text;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
  }



  @override

  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> scholars = FirebaseFirestore.instance.collection("prophet").snapshots();

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                autofocus: false,
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                      },
                    ),
                    hintText: 'Name Of 25 Prophets...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage('assets/image/scholarbg4.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        "Stories of 25 Prophets",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: scholars,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(!snapshot.hasData){
                        return const CircularProgressIndicator();
                      }
                      var da = snapshot.data!.docs.map((e) => e.id).where((element) => element.startsWith(convertToTitleCase(results))).toList();

                      return GridView(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20
                        ),
                        children: List.generate(da.length, (index) {

                          box.writeIfNull(da[index], false);

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => ProphetView(), arguments: [da[index]],
                                  transition: Transition.rightToLeftWithFade,duration: Duration(seconds: 2));
                            },

                            child: Stack(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: const DecorationImage(
                                            image:
                                            AssetImage(
                                                'assets/image/dp.jpg'),
                                            fit: BoxFit.cover)),
                                    padding: const EdgeInsets.all(15),

                                    child: Center(
                                      child: Text(da[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'VarelaRound',
                                            fontWeight: FontWeight.bold, )),

                                    )),
                                Positioned(
                                  width: 280,
                                  height: 75,
                                  child: IconButton(
                                    onPressed: (){
                                      isbook(da[index]);
                                    },
                                    icon: !box.read(da[index])? Icon(Icons.favorite_border, color: Colors.white,) : Icon(Icons.bookmark, color: Colors.amber,),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })

                      );
                    } ),)
            ],
          ),
        ),
      ),
    );
  }
}

