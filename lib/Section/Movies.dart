import 'package:flutter/material.dart';
import 'package:review888/apikey/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:review888/function/slider.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> popularmovie = [];
  List<Map<String, dynamic>> nowplaymovie = [];
  List<Map<String, dynamic>> topratemovie = [];

  var popularmovieurl =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
  var nowplayingmovieurl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
  var topratemovieurl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey';

  Future<void> movieslist() async {
    var popularmovieresponse = await http.get(Uri.parse(popularmovieurl));
    if (popularmovieresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmovieresponse.body);
      var popularmoviejson = tempdata['results'];
      for (var i = 0; i < popularmoviejson.length; i++) {
        popularmovie.add({
          'name': popularmoviejson[i]['title'],
          'poster_path': popularmoviejson[i]['poster_path'],
          'vote_average': popularmoviejson[i]['vote_average'],
          'Date': popularmoviejson[i]['release_date'],
          'id': popularmoviejson[i]['id'],
        });
      }
    } else {
      print(popularmovieresponse.statusCode);
    }

    var nowplayresponse = await http.get(Uri.parse(nowplayingmovieurl));
    if (nowplayresponse.statusCode == 200) {
      var tempdata = jsonDecode(nowplayresponse.body);
      var nowplayjson = tempdata['results'];
      for (var i = 0; i < nowplayjson.length; i++) {
        nowplaymovie.add({
          'name': nowplayjson[i]['title'],
          'poster_path': nowplayjson[i]['poster_path'],
          'vote_average': nowplayjson[i]['vote_average'],
          'Date': nowplayjson[i]['release_date'],
          'id': nowplayjson[i]['id'],
        });
      }
    } else {
      print(nowplayresponse.statusCode);
    }

    var topratedmovieresponse = await http.get(Uri.parse(topratemovieurl));
    if (topratedmovieresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedmovieresponse.body);
      var topratedmoviejson = tempdata['results'];
      for (var i = 0; i < topratedmoviejson.length; i++) {
        topratemovie.add({
          'name': topratedmoviejson[i]['title'],
          'poster_path': topratedmoviejson[i]['poster_path'],
          'vote_average': topratedmoviejson[i]['vote_average'],
          'Date': topratedmoviejson[i]['release_date'],
          'id': topratedmoviejson[i]['id'],
        });
      }
    } else {
      print(topratedmovieresponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieslist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.blue,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sliderlist(popularmovie, "Popular Movies", "movie", 20),
              sliderlist(topratemovie, "Now Playing Movies", "movie", 20),
              sliderlist(nowplaymovie, "Top Rated Movies", "movie", 20),
            ],
          );
        }
      },
    );
  }
}
