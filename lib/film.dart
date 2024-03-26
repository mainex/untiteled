import 'package:flutter/material.dart';

class Film {
  var title = "my film";
  var description = "my film desc";
  var image = Image(
    image: NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
  );

  Film(var _title, var _description, var _image) {
    title = _title;
    description = _description;
    image = _image;
  }
}
