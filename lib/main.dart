import 'package:flutter/material.dart';
import 'package:flutter_task_interview/Ui/HotelDetails.dart';

import 'Ui/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen(),
      routes: {
        "HotelDetail" : (BuildContext context) => HotelDetails()
      },
    );
  }
}
