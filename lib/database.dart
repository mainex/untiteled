// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'film_dao.dart';
import 'film.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Film])
abstract class AppDatabase extends FloorDatabase {
  FilmDao get filmDao;
}