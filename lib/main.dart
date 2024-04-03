import 'package:flutter/material.dart';
import 'package:namer_app/film_dao.dart';
import 'package:namer_app/database.dart';
import 'package:flutter/widgets.dart';

import 'my_app.dart';

late AppDatabase database;
late FilmDao filmDao;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  filmDao = database.filmDao;

  runApp(MyApp());
}

