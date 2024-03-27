import 'package:flutter/material.dart';

class Film {
  var title = "my film";
  var description = "my film desc";
  var imageURL =
      'https://image.tmdb.org/t/p/w440_and_h660_face/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg';

  Film(var _title, var _description, var _url) {
    title = _title;
    description = _description;
    imageURL = _url;
  }
}
