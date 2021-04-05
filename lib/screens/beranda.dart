import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String statusVip;

class BerandaPage extends StatefulWidget{
  @override
  BerandaState createState() => BerandaState();
}

class BerandaState extends State<BerandaPage> {

  List promo = [];
  List filterPromo = [];

  getPromo() async {
    var url = "http://192.168.1.243/rest_flutter/index.php/promo";
    final response = await http.get(url);
    return json.decode(response.body);
  }

  void initState(){
    super.initState();
    _loadpreferenches();
    getPromo().then((data){
      setState(() {
        filterPromo = promo = data;
      });
    });
  }

  void _loadpreferenches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('vip')=='1'){
      setState(() {
        statusVip = "Kamu adalah Member VIP";
      });
    }else{
      setState(() {
        statusVip = "Kamu bukan member VIP";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurpleAccent[100],
              Colors.white60,
              Colors.white,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 35.0,),),
            Container(
                padding: EdgeInsets.only(left: 30.0),
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: (){
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image.asset('images/menu_burger.png', width: 46.0,),
                )
            ),
            Padding(padding: EdgeInsets.only(top: 15.0),),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 35.0),
              child: Text("Cari Reksadana", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
              alignment: Alignment.center,
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: "Search",
                    suffixIcon: GestureDetector(
                      onTap: (){},
                      child: Icon(Icons.search, size: 32,),
                    )
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 35.0, top: 70.0, bottom: 20.0),
              child: Text("Kategori", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
            ),
            Container(
              padding: EdgeInsets.only(left: 35.0, right: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: (){},
                      color: Colors.white,
                      icon: Image.asset('images/iconssatu.png'),
                      label: Text("Absensi"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0),),
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: (){},
                      color: Colors.white,
                      icon: Image.asset('images/iconsdua.png'),
                      label: Text("Original"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0),),
            Container(
              padding: EdgeInsets.only(left: 35.0, right: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: (){},
                      color: Colors.white,
                      icon: Image.asset('images/iconstiga.png'),
                      label: Text("Saham"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0),),
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: (){},
                      color: Colors.white,
                      icon: Image.asset('images/iconsempat.png'),
                      label: Text("Syariah"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 35.0, top: 30.0, bottom: 20.0),
              child: Text("Kategori", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              height: MediaQuery.of(context).size.height * 0.30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterPromo.length,
                  itemBuilder: (BuildContext ccontext, int index){
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("http://192.168.1.243/rest_flutter/assets/image_promo/${filterPromo[index]['gambar']}")
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                            child: Container(
                              padding: EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
                              child: Text(filterPromo[index]['judul'], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}