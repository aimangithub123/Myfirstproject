import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_kidz/model/toggle.dart';
import 'package:the_kidz/view/prophetview.dart';
import 'package:the_kidz/view/scholarview.dart';


class FavouritesView extends StatefulWidget {
  const FavouritesView({Key? key}) : super(key: key);
  @override
  _FavouritesViewState createState() => _FavouritesViewState();}
class _FavouritesViewState extends State<FavouritesView> {
  final box = GetStorage();
  List<String> listScholar = [];
  List<String> listProphet = [];
  bool isScholar = true;
  String isSc = "Islamic Scholars";
  Future<List> listname() async {
    List list = [];
    for(int a = 0; a< box.getKeys().toList().length; a++){
      if(box.read(box.getKeys().toList()[a]) == true){
        list.add(box.getKeys().toList()[a]);
      }}
    return list.toSet().toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.purple,
        title: const Text("Favourites"),
        actions: [
      Expanded(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch(
            onChanged: (value){
              setState(() {
                isScholar = value;
                if(isScholar==true){
                  isSc="Islamic Scholar";
                } else {
                  isSc="Prophet              ";
                }

              });
            },
            value: isScholar,
            activeColor: Colors.blue,
            activeTrackColor: Colors.yellow,
            inactiveTrackColor: Colors.orangeAccent,
            inactiveThumbColor: Colors.pinkAccent,),
          Text("$isSc")

        ],
      ),
    ),
        ],
      ),
      //haziq design bawah ni
      body: (isScholar) ?
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
                image: AssetImage('assets/image/bggif3.gif'),
                fit: BoxFit.cover
            )
        ),
        child: FutureBuilder(
          future: listname(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            listScholar.clear();
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            } else {
              for(var item in snapshot.data){
                if(!item.contains("Prophet")){
                  listScholar.add(item);
                }
              }
              return ListView.builder(
                    itemCount: listScholar.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child:
                         ListTile(

                          onLongPress: (){
                            setState(() { });
                              box.write(listScholar[index], false).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Unfavourite")));
                              });
                          },
                            leading: Icon(Icons.thumb_up,color: Colors.blue,),
                          trailing: Icon(Icons.bookmark, color: Colors.yellow,),
                          onTap: (){ Get.to(() => ScholarView(), arguments: [listScholar[index]],
                            transition: Transition.circularReveal,duration: Duration(seconds: 2));},
                          title: Text(listScholar[index],
                          style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: 'VarelaRound'),)),
                      );
                    },
                  );
            }
          },
        ),
      )
      :
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
                image: AssetImage('assets/image/bggif3.gif'),
                fit: BoxFit.cover
            )
        ),
        child: FutureBuilder(
          future: listname(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            listProphet.clear();
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            } else {
              for(var item in snapshot.data){
                if(item.contains("Prophet")){
                  listProphet.add(item);
                }
              }
              return ListView.builder(
                itemCount: listProphet.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(

                    child: ListTile(
                      //designnnn
                        onLongPress: (){
                          setState(() { });
                          box.write(listProphet[index], false).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Unfavourite")));
                          });
                        },
                        leading: Icon(Icons.thumb_up,color: Colors.pinkAccent),
                        trailing: Icon(Icons.bookmark, color: Colors.yellow,),
                        onTap: (){ Get.to(() => ProphetView(), arguments: [listProphet[index]],
                            transition: Transition.size,duration: Duration(seconds: 2));},
                        title: Text(listProphet[index],
                        style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: 'VarelaRound'),)),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}


