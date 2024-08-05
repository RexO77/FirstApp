// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          //center the title
          centerTitle: true,
          title: Text('My App'),
          backgroundColor: Colors.lightBlue,
          leading: Icon(Icons.menu),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.white))],//just 
        ),
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
            color: Colors.white,
            //curve the corners of the container
            borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(100),
            child: Text(
              'Hello World',
              style: TextStyle(
                fontSize: 30,
                color: Colors.deepPurple,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}