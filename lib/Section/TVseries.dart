import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:review888/apikey/api.dart';
import 'package:review888/function/slider.dart';

class TVseries extends StatefulWidget {
  const TVseries({super.key});

  @override
  State<TVseries> createState() => _TVseriesState();
}

class _TVseriesState extends State<TVseries> {
  List<Map<String, dynamic>> populartvseries = [];
  List<Map<String, dynamic>> onairtvseries = [];
  List<Map<String, dynamic>> topratedtvseries = [];
  var populartvseriesurl =
      'https://api.themoviedb.org/3/tv/popular?api_key=$apikey';
  var topratedtvseriesurl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=$apikey';
  var onairtvseriesurl =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apikey';
  Future<void> tvseriesfunction() async {
    var popularresponse = await http.get(Uri.parse(populartvseriesurl));
    if (popularresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularresponse.body);
      var populartvjson = tempdata['results'];
      for (var i = 0; i < populartvjson.length; i++) {
        populartvseries.add({
          'name': populartvjson[i]['name'],
          'poster_path': populartvjson[i]['poster_path'],
          'vote_average': populartvjson[i]['vote_average'],
          'Date': populartvjson[i]['first_air_date'],
          'id': populartvjson[i]['id'],
        });
      }
    } else {
      print(popularresponse.statusCode);
    }
    var topratedresponse = await http.get(Uri.parse(topratedtvseriesurl));
    if (topratedresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedresponse.body);
      var topratedtvjson = tempdata['results'];
      for (var i = 0; i < topratedtvjson.length; i++) {
        topratedtvseries.add({
          'name': topratedtvjson[i]['name'],
          'poster_path': topratedtvjson[i]['poster_path'],
          'vote_average': topratedtvjson[i]['vote_average'],
          'Date': topratedtvjson[i]['first_air_date'],
          'id': topratedtvjson[i]['id'],
        });
      }
    } else {
      print(topratedresponse.statusCode);
    }

    var onairresponse = await http.get(Uri.parse(onairtvseriesurl));
    if (onairresponse.statusCode == 200) {
      var tempdata = jsonDecode(onairresponse.body);
      var onairtvjson = tempdata['results'];
      for (var i = 0; i < onairtvjson.length; i++) {
        onairtvseries.add({
          'name': onairtvjson[i]['name'],
          'poster_path': onairtvjson[i]['poster_path'],
          'vote_average': onairtvjson[i]['vote_average'],
          'Date': onairtvjson[i]['first_air_date'],
          'id': onairtvjson[i]['id'],
        });
      }
    } else {
      print(onairresponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tvseriesfunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sliderlist(populartvseries, "Popular TV Series", "tv", 20),
              sliderlist(onairtvseries, "On air ", "tv", 20),
              sliderlist(topratedtvseries, "Top Rated TV Series", "tv", 20)
            ],
          );
        }
      },
    );
  }
}
