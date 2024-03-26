import 'package:http/http.dart' as http;
import 'film.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

Map<String, String> requestHeaders = {
  'accept': 'application/json',
  'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYzU2NDcxNTJiYzE2ZDJjMTk5N2RjOWM3YjZjZDhhMCIsInN1YiI6IjY1ZTg5ZjgzYzE1Zjg5MDE4NjE3OTZiMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Y1KsiSdRMVmY2_B4iW_ofV14-HMsfNz5iNBcVHqIVqY'
};

Future<String> _getNowInCinema() async {
  Uri uri = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1');
  http.Response response = await http.get(uri, headers: requestHeaders);
  return response.body.toString();
}

Image _getImage(String path) {
  final image = Image(
    image:
        NetworkImage('https://image.tmdb.org/t/p/w440_and_h660_face/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg'),
  );
  return image;
}

Future<List<Film>> getNowInCinemaList() async {
  String data = await _getNowInCinema();
  final jsonData = json.decode(data)['results'];
  List<Film> list = [];
  for (var i = 0; i < 10; ++i) {
    final title = jsonData[i]['original_title'];
    final year = DateTime.parse(jsonData[i]['release_date']).year.toString();
    final image = _getImage(jsonData[i]['poster_path']);
    Film film = Film(title, year, image);
    list.add(film);
  }
  return list;
}

Future<String> _getUpcoming() async {
  Uri uri = Uri.parse(
      'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1');
  http.Response response = await http.get(uri, headers: requestHeaders);
  return response.body.toString();
}

String toString(DateTime date) {
  Map<int, String> map = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };
  return date.day.toString() + ' ' + map[date.month]!;
}

Future<List<Film>> getReleaseCalendarList() async {
  String data = await _getUpcoming();
  final jsonData = json.decode(data)['results'];
  List<Film> list = [];
  for (var i = 0; i < 20; ++i) {
    final title = jsonData[i]['original_title'];
    final date = DateTime.parse(jsonData[i]['release_date']);
    final desc = toString(date);
    final image = _getImage(jsonData[i]['poster_path']);
    Film film = Film(title, desc, image);
    list.add(film);
  }
  return list;
}
