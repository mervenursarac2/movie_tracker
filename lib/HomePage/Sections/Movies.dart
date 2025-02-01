import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_tracker/allapilinks/allapi.dart';
import 'package:movie_tracker/repeted/slider.dart';
import 'package:movie_tracker/repeted/fetchlist.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {

  List<Map<String, dynamic>> popularmovies = [];
  List<Map<String, dynamic>> topratedmovies = [];
  List<Map<String, dynamic>> upcomingmovies = [];
  List<Map<String, dynamic>> scificmovies = [];
  List<Map<String, dynamic>> romanticmovies = [];

///////////////////////////////////////////////////////

  var popularmoviesurl =
      'https://api.themoviedb.org/3/movie/popular?api_key=1c08fd61d20a1d3754bd70c470d80cb9&language=en-US&page=1';
  var topratedmoviesurl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=1c08fd61d20a1d3754bd70c470d80cb9';
  var upcomingmoviesurl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=1c08fd61d20a1d3754bd70c470d80cb9';
  var scificmoviesurl =
      'https://api.themoviedb.org/3/discover/movie?api_key=1c08fd61d20a1d3754bd70c470d80cb9&with_genres=878';
  var romanticmoviesurl =
      'https://api.themoviedb.org/3/discover/movie?api_key=1c08fd61d20a1d3754bd70c470d80cb9&with_genres=10749';

  ///////////////////////////////////////////////////////////////

  Future<void> moviesfunction() async {
    popularmovies = await fetchContent(
        popularmoviesurl , 'movie');
    topratedmovies = await fetchContent(
        topratedmoviesurl, 'movie');
    upcomingmovies= await fetchContent(
        upcomingmoviesurl,'movie');
    scificmovies = await fetchContent(
        scificmoviesurl,'movie');
    romanticmovies = await fetchContent(
        romanticmoviesurl,'movie');

    /////////////////////////////////////////////////////////////////////7

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: moviesfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sliderlist(popularmovies, "popular movies", "movie", 20),
                  sliderlist(topratedmovies, "top rated movies", "movie", 20),
                  sliderlist(scificmovies, "sci-fic", "movie", 20),
                  sliderlist(romanticmovies, "romantic", "movie", 20),
                  sliderlist(upcomingmovies, "upcoming movies", "movie", 20),
                ],
              ),
            );
          }
        });
  }
}
