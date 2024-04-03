// dao/film_dao.dart

import 'package:floor/floor.dart';

import 'film.dart';

@dao
abstract class FilmDao {
  @insert
  Future<void> insertFilm(Film film);

  @Query('SELECT * FROM Film')
  Future<List<Film>> findAllFilms();

  @Query('SELECT * FROM Film WHERE id = :id')
  Stream<Film?> findFilmById(int id);

  @Query('DELETE FROM Film WHERE id = :id')
  Future<void> removeFilmByID(int id);
}
