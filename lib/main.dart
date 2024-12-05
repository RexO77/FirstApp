// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui'; // For glassmorphic effect
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtistryWalls',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto', // Use a custom font
      ),
      home: const WallpaperHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WallpaperHomePage extends StatefulWidget {
  const WallpaperHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WallpaperHomePageState createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final Set<String> favorites = {};
  int _tapCounter = 0;
  DateTime _lastTapTime = DateTime.now();
  late AnimationController animationController;

  final List<String> wallpapers = [
    'assets/mobilewalls/10.png',
    'assets/mobilewalls/11.png',
    'assets/mobilewalls/12.png',
    'assets/mobilewalls/13.png',
    'assets/mobilewalls/14.png',
    'assets/mobilewalls/15.png',
    'assets/mobilewalls/16.png',
    'assets/mobilewalls/17.png',
    'assets/mobilewalls/18.png',
    'assets/mobilewalls/19.png',
    'assets/mobilewalls/20.png',
    'assets/mobilewalls/21.png',
    'assets/mobilewalls/22.png',
    'assets/mobilewalls/23.png',
    'assets/mobilewalls/24.png',
    'assets/mobilewalls/25.png',
    // Add more image paths
  ];

  @override
  void initState() {
    super.initState();
      animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> _downloadImage(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final buffer = byteData.buffer;
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory?.path}/${assetPath.split('/').last}';
      final file = File(filePath);
      await file.writeAsBytes(buffer.asUint8List(
          byteData.offsetInBytes, byteData.lengthInBytes));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image downloaded to $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to download image')),
      );
    }
  }

  void _handleTap(String image) {
    final now = DateTime.now();
    if (now.difference(_lastTapTime) > const Duration(milliseconds: 500)) {
      _tapCounter = 0;
    }
    _tapCounter++;
    _lastTapTime = now;

    if (_tapCounter == 2) {
      // Double-tap detected - Toggle favorite
      setState(() {
        if (favorites.contains(image)) {
          favorites.remove(image);
        } else {
          favorites.add(image);
        }
      });
    } else if (_tapCounter == 3) {
      // Triple-tap detected - Download image
      _downloadImage(image);
      _tapCounter = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Home Page
      Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: wallpapers.length,
              itemBuilder: (context, index, realIndex) {
                final image = wallpapers[index];
                final isFavorite = favorites.contains(image);
                return GestureDetector(
                  onTap: () => _handleTap(image),
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      if (isFavorite)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                        ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                scrollDirection: Axis.vertical,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
            ),
          ),
        ],
      ),
      // Categories Page (Placeholder)
      Center(
        child: Text(
          'Categories',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      // Favorites Page
      GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favorites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust as needed
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final image = favorites.elementAt(index);
          return Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('ArtistryWalls'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          pages[_currentIndex],
        ],
      ),
      bottomNavigationBar: GlassmorphicNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class GlassmorphicNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GlassmorphicNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
            ],
          ),
        ),
      ),
    );
  }
}