import 'package:flutter/cupertino.dart';
import 'api.dart';
import 'film.dart';
import 'main.dart';

class MyAppState extends ChangeNotifier {
  var watchList = [];
  var todayInCinemaList = getNowInCinemaList();
  var releaseCalendarList = getReleaseCalendarList();

  void addToWatchList(Film film) async {
    if (await filmDao.findFilmById(film.id).first == null) {
      filmDao.insertFilm(film);
      watchList.add(film);
    }
    notifyListeners();
  }
}
