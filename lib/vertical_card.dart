import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'film.dart';
import 'my_app_state.dart';

class VerticalCard extends StatelessWidget {
  const VerticalCard({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var text, icon;
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
          width: 130,
          height: 280,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 130,
                color: null,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(film.imageURL), fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 11,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(film.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(film.shortDesc,
                    style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    textAlign: TextAlign.left),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton.icon(
                    onPressed: () {
                      appState.addToWatchList(film);
                    },
                    icon: Icon(icon),
                    label: Text(text)),
              )
            ],
          )),
    );
  }
}
