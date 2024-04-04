import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'film.dart';
import 'my_app_state.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    String text;
    IconData icon;
    if (appState.watchList.keys.contains(film.id)) {
      text = 'Remove';
      icon = Icons.delete;
    } else {
      text = 'Add';
      icon = Icons.add;
    }
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
              Container(
                width: 180,
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
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[500]),
                          textAlign: TextAlign.left),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleWatchList(film);
                    },
                    icon: Icon(icon),
                    label: Text(text)),
              )
            ],
          )),
    );
  }
}
