import 'package:http/http.dart' as http;
import 'film.dart';
import 'dart:convert';

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

Future<Map<int, Film>> getNowInCinemaList() async {
  String data = await _getNowInCinema();
  final jsonData = json.decode(data)['results'];
  Map<int, Film> map = {};
  for (var i = 0; i < 10; ++i) {
    Film film = Film.fromJson(jsonData[i], 0);
    map[film.id] = film;
  }
  return map;
}

Future<String> _getUpcoming() async {
  Uri uri = Uri.parse(
      'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1');
  http.Response response = await http.get(uri, headers: requestHeaders);
  return response.body.toString();
}

Future<Map<int, Film>> getReleaseCalendarList() async {
  String data = await _getUpcoming();
  final jsonData = json.decode(data)['results'];
  Map<int, Film> map = {};
  for (var i = 0; i < 20; ++i) {
    Film film = Film.fromJson(jsonData[i], 1);
    map[film.id] = film;
  }
  return map;
}

Future<String> _searchMovie(String query) async {
  Uri uri = Uri.parse('https://api.themoviedb.org/3/search/movie?query=' +
      query +
      '&include_adult=true&language=en-US&page=1');
  http.Response response = await http.get(uri, headers: requestHeaders);
  return response.body.toString();
}

Future<List<Film>> searchMovie(String query) async {
  String data = await _searchMovie(query);
  final jsonData = json.decode(data)['results'];
  List<Film> list = [];
  for (var filmData in jsonData) {
    Film film = Film.fromJson(filmData, 1);
    list.add(film);
  }
  return list;
}
