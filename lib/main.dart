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
          title: Text('My App'),
          backgroundColor: Colors.deepPurple,
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