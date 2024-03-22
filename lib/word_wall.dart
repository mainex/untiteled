import 'package:flutter/material.dart';
import 'vertical_card.dart';
import 'film.dart';

class WordWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}