import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_01.dart';
import 'homepage_00.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Myapp(),
    );
  }
}

class Myapp extends StatefulWidget {
  Myapp({
    super.key,
  });

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  int selectedIndex = 0;
  bool safearea = true;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = NumberInputPage();
        break;
      case 1:
        page = Favorite();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              setState(() {
                safearea = !safearea;
              });
            }),
        title: Text(
          'Random Number Generator App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: safearea
          ? Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: false,
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                        safearea = !safearea;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: page,
                  ),
                ),
              ],
            )
          : Center(
              child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                  child: page)),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<int> favorites = [];

  void toggleFavorite(int value) {
    if (favorites.contains(value)) {
      favorites.remove(value);
    } else {
      favorites.add(value);
    }
    notifyListeners();
  }
}
