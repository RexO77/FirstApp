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
      title: 'Wallpaper Showcase',
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
      'assets/mobilewalls/5.jpeg',
      'assets/mobilewalls/6.jpeg',
      'assets/mobilewalls/7.jpeg',
      'assets/mobilewalls/8.jpg',
      'assets/mobilewalls/9.jpeg',
      'assets/mobilewalls/10.png',
      'assets/mobilewalls/11.png',
      'assets/mobilewalls/12.png',
      'assets/mobilewalls/13.png',
      'assets/mobilewalls/14.png',
      'assets/mobilewalls/15.png',
      'assets/mobilewalls/16.png',
      'assets/mobilewalls/17.png',
      'assets/mobilewalls/18.png',
      // Add more image paths
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper Showcase'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.4,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: wallpapers.map((item) {
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
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Grid View
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: wallpapers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2x2 grid
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        wallpapers[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}