import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Name App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MediaPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = Placeholder();
      case 3:
        page = Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Expanded(
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: page,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Watch List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        backgroundColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[800],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

class MediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Container(
        color: Colors.white,
        child: ListView(scrollDirection: Axis.vertical, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Media",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto')),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Today in cinema",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto')),
          ),
          Container(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 20,
                ),
                VerticalCard(film: Film("1", "1")),
                VerticalCard(film: Film("2", "2")),
                VerticalCard(film: Film("3", "3")),
                VerticalCard(film: Film("4", "4")),
                VerticalCard(film: Film("5", "5")),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Release calendar",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto')),
          ),
          Container(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 20,
                ),
                VerticalCard(film: Film("1", "1")),
                VerticalCard(film: Film("2", "2")),
                VerticalCard(film: Film("3", "3")),
                VerticalCard(film: Film("4", "4")),
                VerticalCard(film: Film("5", "5")),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ]));
  }
}

class Film {
  var title = "my film";
  var description = "my film desc";

  Film(var _title, var _description) {
    title = _title;
    description = _description;
  }
}

class VerticalCard extends StatelessWidget {
  const VerticalCard({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: LinearBorder(),
      elevation: 0,
      color: Colors.white,
      child: SizedBox(
          width: 130,
          height: 280,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 130,
                color: Colors.red,
              ),
              SizedBox(
                height: 11,
              ),
              Text(film.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left),
              Text(film.description,
                  style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                  textAlign: TextAlign.left),
            ],
          )),
    );
  }
}
