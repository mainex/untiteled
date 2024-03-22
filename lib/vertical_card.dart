import 'package:flutter/material.dart';
import 'film.dart';

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
                color: Colors.yellow,
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