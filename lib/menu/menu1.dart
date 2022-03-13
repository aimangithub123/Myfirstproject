import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_kidz/controller/data.dart';
import 'package:the_kidz/view/scholarview.dart';
import 'package:the_kidz/controller/string_extension.dart';


class Menu1 extends StatefulWidget {


  @override
  State<Menu1> createState() => _Menu1State();
}

class _Menu1State extends State<Menu1> {

  TextEditingController searchController = new TextEditingController();
  bool book = false;
  String results = "";
  String scholarId = "";
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


  Future fetchBook(String id) async {
    var document = await FirebaseFirestore.instance.collection("islamic scholar").doc(id).get();
    return document;
  }

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

  Widget build(BuildContext context) {

    var scholar = FirebaseFirestore.instance.collection("islamic scholar");
    final Stream<QuerySnapshot> scholars = scholar
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
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
                    hintText: 'Name Of Islamic Scholars...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage('assets/image/scholarbg.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.1),
                        Colors.black.withOpacity(.1),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        " Islamic Scholars",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
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
                      var da = snapshot.data!.docs.map((e) => e.id)
                          .where((element) => element.startsWith(convertToTitleCase(results)))
                          .toList();
                      return GridView(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20
                          ),
                          children: List.generate(da.length, (index) {
                            box.writeIfNull(da[index], false);
                              return  GestureDetector(
                                onTap: () {
                                  Get.to(() => const ScholarView(), arguments: [da[index]],
                                      transition: Transition.cupertinoDialog,duration: const Duration(seconds: 2));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            image: const DecorationImage(
                                                image:
                                                AssetImage(
                                                    'assets/image/lava.gif'),
                                                fit: BoxFit.cover)),
                                        padding: const EdgeInsets.all(20),
                                        child: Center(
                                          child: Text(da[index],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  color: Colors.white,
                                                  fontFamily: 'VarelaRound',
                                                  fontWeight: FontWeight.bold)),

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

                          }
                          )
                      );
                    } ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

