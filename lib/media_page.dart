import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/word_wall.dart';
import 'package:provider/provider.dart';

import 'film.dart';
import 'my_app_state.dart';

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
