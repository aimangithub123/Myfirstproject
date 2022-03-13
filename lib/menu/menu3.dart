import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_kidz/model/Hadith.dart';
import 'package:the_kidz/view/duaview.dart';
import 'package:the_kidz/controller/string_extension.dart';


class Menu3 extends StatefulWidget {


  @override
  State<Menu3> createState() => _Menu3State();
}

class _Menu3State extends State<Menu3> {

  TextEditingController searchController = new TextEditingController();
  bool book = false;
  String results = "";
  String duasId = "";
  bool isDua=true;
  String isD="Daily Duas";

  //variable hadith
  String text = "";
  Hadith hadith = new Hadith();
  late Future getData;



  @override
  void initState() {
    // TODO: implement initState
    getData = hadith.fetchHadith();
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
    var document = await FirebaseFirestore.instance.collection("daily duas ").doc(id).get();
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

    var duas = FirebaseFirestore.instance.collection("daily duas");
    final Stream<QuerySnapshot>  duasId = duas.snapshots();
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: (isDua) ? AppBar(
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
                    hintText: 'Daily Duas...',
                    border: InputBorder.none),
              ),
            ),
          )) : AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
              title: Text("Hadith"),
              actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                // color: Colors.purple,
                  borderRadius: BorderRadius.circular(10)
              ),
              // child: Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: (isDua) ? Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/bggif5.gif"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
            mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("$isD", style: TextStyle(color: Colors.white),),
                Switch(
                  onChanged: (value){
                    setState(() {
                      isDua = value;
                      if(isDua==true){
                        isD="Daily Duas";
                      } else {
                        isD="Hadith       "; //style: TextStyle(color: Colors.white, fontSize: 65,fontWeight: FontWeight.bold);
                      }

                    });
                  },
                  value: isDua,
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.yellow,
                  inactiveTrackColor: Colors.orangeAccent,
                  inactiveThumbColor: Colors.pinkAccent,),
              ],
              ),
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage('assets/image/scholarbg2.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.4),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        " Daily Essential Duas",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.center,
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
                    stream: duasId,
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
                                Get.to(() => DuaView(), arguments: [da[index]],
                                    transition: Transition.downToUp,duration: Duration(seconds: 2));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: const DecorationImage(
                                              image:
                                              AssetImage(
                                                  'assets/image/lavalamp.gif'),
                                              fit: BoxFit.cover)),
                                      padding: const EdgeInsets.all(5),
                                      child: Center(
                                        child: Text(da[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                                fontFamily: 'VarelaRound',
                                                fontWeight: FontWeight.bold)),

                                      )),
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
        )
        :
            /*** Hadith***/
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/circle.gif"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("$isD", style: TextStyle(color: Colors.black),),
                  Switch(
                    onChanged: (value){
                      setState(() {
                        isDua = value;
                        if(isDua==true){
                          isD="Daily Duas";
                        } else {
                          isD="Hadith       "; style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold);
                        }

                      });
                    },
                    value: isDua,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.yellow,
                    inactiveTrackColor: Colors.orangeAccent,
                    inactiveThumbColor: Colors.pinkAccent,),
                ],
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                        image: AssetImage('assets/image/scholarbg5.jpg'),
                        fit: BoxFit.cover
                    )),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.4),
                            Colors.black.withOpacity(.2),
                          ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text("Hadith", style: TextStyle(color: Colors.white, fontSize: 65,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
                      SizedBox(height: 55,),
                      SizedBox(height: 15,)
                    ],),),),
              const SizedBox(height: 60),
              Expanded(
                child: FutureBuilder(
                  future: getData,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      String d = snapshot.data.toString();
                      return SingleChildScrollView(
                        child: Text(d, style: const TextStyle(fontFamily: 'Comfortaa',fontSize: 21, color: Colors.black,fontWeight: FontWeight.w600),
                          textAlign: TextAlign.justify,),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}





