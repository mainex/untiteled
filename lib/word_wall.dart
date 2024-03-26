import 'package:flutter/material.dart';
import 'vertical_card.dart';
import 'film.dart';
import 'api.dart';

class FilmWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 320,
        child: FutureBuilder<List<Film>>(
            future: getTopMoviesArray(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      VerticalCard(film: snapshot.data![0]),
                      VerticalCard(film: snapshot.data![1]),
                      VerticalCard(film: snapshot.data![2]),
                      VerticalCard(film: snapshot.data![3]),
                      VerticalCard(film: snapshot.data![4]),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  );
              }
            }));
  }
}
