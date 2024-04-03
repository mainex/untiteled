import 'package:flutter/cupertino.dart';
import 'api.dart';
import 'film.dart';
import 'main.dart';

class MyAppState extends ChangeNotifier {
  var watchList = {};
  var todayInCinemaList = getNowInCinemaList();
  var releaseCalendarList = getReleaseCalendarList();

  void addToWatchList(Film film) async {
    if (await filmDao.findFilmById(film.id).first == null) {
      filmDao.insertFilm(film);
      watchList[film.id] = film;
    } else {
      filmDao.removeFilmByID(film.id);
      watchList.remove(film.id);
    }
    notifyListeners();
  }
}
