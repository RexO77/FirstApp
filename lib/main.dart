// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const WallpaperApp());
}

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Carousel',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const WallpaperHomePage(),
    );
  }
}

class WallpaperHomePage extends StatelessWidget {
  const WallpaperHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> wallpapers = [
      'assets/mobilewalls/1.jpg',
      'assets/mobilewalls/2.jpeg',
      'assets/mobilewalls/3.jpg',
      'assets/mobilewalls/4.jpeg',
      'assets/mobilewalls/5.jpeg',
      'assets/mobilewalls/6.jpeg',
      'assets/mobilewalls/7.jpeg',
      // Add more image paths
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper Carousel'),
        centerTitle: true,
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.6,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: wallpapers.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}