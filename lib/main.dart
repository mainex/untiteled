import 'package:flutter/material.dart';
import 'package:namer_app/api.dart';
import 'package:namer_app/film_dao.dart';
import 'package:namer_app/horizontal_card.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/database.dart';
import 'package:namer_app/word_wall.dart';
import 'package:namer_app/film.dart';
import 'package:flutter/widgets.dart';

late AppDatabase database;
late FilmDao filmDao;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  filmDao = database.filmDao;

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
  var watchList = [];

  //filmDao.findAllFilms();
  var todayInCinemaList = getNowInCinemaList();
  var releaseCalendarList = getReleaseCalendarList();

  void addToWatchList(Film film) async {
    if (await filmDao.findFilmById(film.id).isEmpty) {
      filmDao.insertFilm(film);
      watchList.add(film);
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
        page = WatchListPage();
        break;
      case 2:
        page = SearchPage();
      case 3:
        page = Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Center(
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

class WatchListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title:
            Align(alignment: Alignment.center, child: const Text('Watch List')),
        titleTextStyle: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
      ),
      body: FutureBuilder<List<Film>>(
          future: filmDao.findAllFilms(),
          builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                appState.watchList = snapshot.data!;
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('You have '
                          '${appState.watchList.length} in watch list:'),
                    ),
                    for (var film in appState.watchList)
                      HorizontalCard(film: film),
                  ],
                );
            }
          }),
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
          FutureBuilder<Map<int, Film>>(
              future: appState.todayInCinemaList,
              builder: (BuildContext context,
                  AsyncSnapshot<Map<int, Film>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    return FilmWall(snapshot.data!);
                }
              }),
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
          FutureBuilder<Map<int, Film>>(
              future: appState.releaseCalendarList,
              builder: (BuildContext context,
                  AsyncSnapshot<Map<int, Film>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    return FilmWall(snapshot.data!);
                }
              }),
        ]));
  }
}

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  var searchResults = searchMovie('');

  void onQueryChanged(String newQuery) {
    query = newQuery;
    setState(() {
      searchResults = searchMovie(query);
    });
    print(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                onChanged: onQueryChanged,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Film>>(
                  future: searchResults,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Film>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        return ListView(
                          children: [
                            if (snapshot.data != null)
                              for (var film in snapshot.data!)
                                HorizontalCard(film: film)
                            else
                              ListTile(title: const Text('no'))
                          ],
                        );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
