import 'package:flutter/material.dart';
import 'vertical_card.dart';
import 'film.dart';
import 'api.dart';

class FilmWall extends StatelessWidget {
  List<Film> listOfFilms;

  FilmWall(this.listOfFilms);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 340,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: 20,
            ),
            VerticalCard(film: listOfFilms[0]),
            VerticalCard(film: listOfFilms[1]),
            VerticalCard(film: listOfFilms[2]),
            VerticalCard(film: listOfFilms[3]),
            VerticalCard(film: listOfFilms[4]),
            VerticalCard(film: listOfFilms[5]),
            VerticalCard(film: listOfFilms[6]),
            VerticalCard(film: listOfFilms[7]),
            VerticalCard(film: listOfFilms[8]),
            SizedBox(
              width: 20,
            ),
          ],
        ));
  }
}
