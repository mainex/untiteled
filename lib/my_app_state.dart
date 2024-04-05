import 'package:flutter/cupertino.dart';
import 'api.dart';
import 'film.dart';
import 'main.dart';

class MyAppState extends ChangeNotifier {
  var todayInCinemaList = getNowInCinemaList();
  var releaseCalendarList = getReleaseCalendarList();


  // add film to watch list
  void toggleWatchList(Film film) async {
    if (await filmDao.findFilmById(film.id).first == null) {
      // insert film
      filmDao.insertFilm(film);
    } else {
      // remove film
      filmDao.removeFilmByID(film.id);
    }
    notifyListeners();
  }
}
