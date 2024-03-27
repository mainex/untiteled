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

class Film {
  var id = 0;
  var title = "my film";
  var shortDesc = 'my film desc';
  var imageURL = 'https://image.tmdb.org/t/p/w440_and_h660_face';
  var overview = 'overview';
  var genre = 'genre';
  var voteAverage = '7.0';
  var year = '2024';
  var releaseDateMonth = '';
  DateTime releaseDate = DateTime.now();

  Film(var jsonData, var shortDescType) {
    id = jsonData['id'];
    title = jsonData['title'];
    overview = jsonData['overview'];
    releaseDate = DateTime.parse(jsonData['release_date']);
    voteAverage = jsonData['vote_average'].toString();
    year = releaseDate.year.toString();
    releaseDateMonth = toString(releaseDate);
    imageURL += jsonData['poster_path'];
    if (1 == shortDescType) {
      shortDesc = releaseDateMonth;
    } else {
      shortDesc = year;
    }
  }
}
