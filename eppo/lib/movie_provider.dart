import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/trending.dart';

final movieListProvider = FutureProvider<List<Trending>>((ref) async {
  // Your dummy JSON data
  const jsonString = '''
    [
      {
        "title": "The Shawshank Redemption",
        "director": "Frank Darabont",
        "year": 1994
      },
      {
        "title": "The Godfather",
        "director": "Francis Ford Coppola",
        "year": 1972
      },
      {
        "title": "The Dark Knight",
        "director": "Christopher Nolan",
        "year": 2008
      }
    ]
  ''';

  // Convert JSON string to List of Maps
  final List<dynamic> jsonList = jsonDecode(jsonString);

  // Map each Map to a Movie object
  final List<Trending> movies =
      jsonList.map((json) => Trending.fromJson(json)).toList();

  return movies;
});
