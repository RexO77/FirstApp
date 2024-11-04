// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(WallpaperApp());
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
      home: WallpaperHomePage(),
    );
  }//comment
}

class WallpaperHomePage extends StatefulWidget {
  const WallpaperHomePage({super.key});

  @override
  _WallpaperHomePageState createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage> {
  // Sample list of wallpaper URLs
  final List<String> wallpapers = [
    'https://example.com/wallpaper1.jpg',
    'https://example.com/wallpaper2.jpg',
    // Add more URLs
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper Showcase'),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: wallpapers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two images per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to detail view with animation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WallpaperDetailPage(
                    imageUrl: wallpapers[index],
                    tag: 'wallpaper$index',
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'wallpaper$index',
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(wallpapers[index]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WallpaperDetailPage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  WallpaperDetailPage({super.key, required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper Detail'),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}