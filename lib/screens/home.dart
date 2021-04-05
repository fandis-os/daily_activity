import 'dart:convert';

import 'package:daily_activity/screens/beranda.dart';
import 'package:daily_activity/screens/profile.dart';
import 'package:daily_activity/screens/statistik.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



String statusVip;

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  void initState(){
    super.initState();
    _loadpreferenches();
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
      child: SafeArea(
        child: Scaffold(
            body: PageHome()
        ),
      ),
    );
  }

}

class PageHome extends StatefulWidget {

  final drawerItem = [
    new DrawerItem("Home", "images/iconssatu.png"),
    new DrawerItem("Profile", "images/iconsdua.png"),
    new DrawerItem("Statistik", "images/iconstiga.png"),

  ];

  @override
  _PageHomeState createState() => _PageHomeState();
}

class DrawerItem {
  String title;
  String icon;
  DrawerItem(this.title,this.icon);
}

class _PageHomeState extends State<PageHome> {

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new BerandaPage();
      case 1:
        return new ProfilePage();
      case 2:
        return new StatistikPage();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItem.length; i++) {
      var d = widget.drawerItem[i];
      drawerOptions.add(
          new ListTile(
            leading: new Image.asset(d.icon),
            title: new Text(d.title, style: TextStyle(fontWeight: FontWeight.bold),),
            // trailing: new Icon(Icons.arrow_right),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return Scaffold(
      drawer: new Drawer(
        child: Container(
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
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30.0),),
              Column(children: drawerOptions)
            ],
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}


