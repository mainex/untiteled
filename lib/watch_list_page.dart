import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'film.dart';
import 'horizontal_card.dart';
import 'main.dart';
import 'my_app_state.dart';

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
