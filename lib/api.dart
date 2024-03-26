import 'package:http/http.dart' as http;
import 'film.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

Future<String> _getNowInCinema() async {
  Map<String, String> requestHeaders = {
    'accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYzU2NDcxNTJiYzE2ZDJjMTk5N2RjOWM3YjZjZDhhMCIsInN1YiI6IjY1ZTg5ZjgzYzE1Zjg5MDE4NjE3OTZiMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Y1KsiSdRMVmY2_B4iW_ofV14-HMsfNz5iNBcVHqIVqY'
  };
  Uri uri = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1');
  http.Response response = await http.get(uri, headers: requestHeaders);
  return response.body.toString();
}

Future<List<Film>> getTopMoviesArray() async {
  String data = await _getNowInCinema();
  final jsonData = json.decode(data)['results'];
  List<Film> list = [];
  for (var i = 0; i < 10; ++i) {
    final title = jsonData[i]['original_title'];
    final year = DateTime.parse(jsonData[i]['release_date'] + ' 00:00:00')
        .year
        .toString();
    Film film = Film(title, year);
    list.add(film);
  }
  return list;
}
