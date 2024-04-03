import 'package:flutter/material.dart';
import 'vertical_card.dart';
import 'film.dart';

class FilmWall extends StatelessWidget {
  Map<int, Film> listOfFilms;

  FilmWall(this.listOfFilms);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: 20,
            ),
            for (var film in listOfFilms.values)
              VerticalCard(film: film),
            SizedBox(
              width: 20,
            ),
          ],
        ));
  }
}
