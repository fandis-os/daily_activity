import 'package:daily_activity/screens/home.dart';
import 'package:daily_activity/screens/profile.dart';
import 'package:daily_activity/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash',
    home: SplashPage(),
    routes: <String,WidgetBuilder>{
      '/Homepage': (BuildContext context)=>new HomePage(),
      '/Profile': (BuildContext context)=>new ProfilePage()
    },
  ));
}
