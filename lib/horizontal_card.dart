import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';
import 'film.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Card(
      shape: LinearBorder(),
      elevation: 0,
      color: Colors.white,
      child: SizedBox(
          height: 130,
          child: Row(
            children: [
              Container(
                height: 128,
                width: 84,
                color: null,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(film.imageURL), fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 11,
              ),
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(film.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(film.year,
                          style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                          textAlign: TextAlign.left),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
