// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:swipe_cards/swipe_cards.dart';
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
    return CupertinoApp(
      title: 'ArtistryWalls',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: const WallpaperHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WallpaperHomePage extends StatefulWidget {
  const WallpaperHomePage({super.key});

  @override
  _WallpaperHomePageState createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage> {
  late MatchEngine _matchEngine;
  final Set<String> favorites = {};
  List<SwipeItem> _swipeItems = [];
  DateTime _lastTapTime = DateTime.now();
  int _tapCounter = 0;
  int _currentIndex = 0;

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
    'assets/mobilewalls/26.png',
    'assets/mobilewalls/27.png',
    // Add more image paths
  ];

  @override
  void initState() {
    super.initState();

    for (var image in wallpapers) {
      _swipeItems.add(
        SwipeItem(
          content: image,
          likeAction: () {
            // Swiped right - Add to favorites
            setState(() {
              favorites.add(image);
            });
          },
          nopeAction: () async {
            // Swiped left - Set as wallpaper
            await _setWallpaper(image);
          },
        ),
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  Future<void> _setWallpaper(String assetPath) async {
    // Implement platform-specific code to set the wallpaper
    // This may require additional permissions and packages
  }

  Future<void> _downloadImage(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final buffer = byteData.buffer;
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${assetPath.split('/').last}';
      final file = File(filePath);
      await file.writeAsBytes(buffer.asUint8List(
          byteData.offsetInBytes, byteData.lengthInBytes));
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Download Successful'),
          content: Text('Image saved to $filePath'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Download Failed'),
          content: const Text('Unable to save image'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
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
      CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('ArtistryWalls'),
          border: null,
        ),
        child: Column(
          children: [
            Expanded(
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (context, index) {
                  final image = wallpapers[index];
                  return Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: CupertinoColors.systemGrey,
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
                      ),
                    ),
                  );
                },
                onStackFinished: () {
                  // Handle when all cards are swiped
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const Text('No More Wallpapers'),
                      content: const Text('You have swiped through all wallpapers.'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Categories Page (Placeholder)
      CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Categories'),
          border: null,
        ),
        child: Center(
          child: Text(
            'Coming Soon',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ),
      ),
      // Favorites Page
      CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Favorites'),
          border: null,
        ),
        child: GridView.builder(
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
                    color: CupertinoColors.systemGrey2,
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
      ),
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.collections),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Favorites',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return pages[index];
      },
    );
  }
}