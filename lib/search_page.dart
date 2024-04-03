import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'film.dart';
import 'horizontal_card.dart';

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