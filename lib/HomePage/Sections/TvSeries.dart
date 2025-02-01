import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_tracker/allapilinks/allapi.dart';
import 'package:movie_tracker/repeted/slider.dart';
import 'package:movie_tracker/repeted/fetchlist.dart';

class Tvseries extends StatefulWidget {
  const Tvseries({super.key});

  @override
  State<Tvseries> createState() => _TvseriesState();
}

class _TvseriesState extends State<Tvseries> {
  List<Map<String, dynamic>> populartvseries = [];
  List<Map<String, dynamic>> topratedtvseries = [];
  List<Map<String, dynamic>> upcomingtvseries = [];
  List<Map<String, dynamic>> comedytvseries = [];
  List<Map<String, dynamic>> actiontvseries = [];
////////////////////////////////////////////////////////7
  var popularseriesurl =
      'https://api.themoviedb.org/3/tv/popular?api_key=1c08fd61d20a1d3754bd70c470d80cb9&language=en-US&page=1';
  var topratedtvurl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=1c08fd61d20a1d3754bd70c470d80cb9&language=en-US&page=1';
  var comedytvurl =
      'https://api.themoviedb.org/3/discover/tv?api_key=1c08fd61d20a1d3754bd70c470d80cb9&language=en-US&sort_by=popularity.desc&page=1&with_genres=35';
  var actiontvurl =
      'https://api.themoviedb.org/3/discover/tv?api_key=1c08fd61d20a1d3754bd70c470d80cb9&language=en-US&sort_by=popularity.desc&page=1&with_genres=10759';
  var upcomingtvseriesurl =
      'https://api.themoviedb.org/3/discover/tv?api_key=1c08fd61d20a1d3754bd70c470d80cb9&language=en-US&sort_by=first_air_date.asc&first_air_date.gte=2024-12-26&page=1';

  ///////////////////////////////////////////////////////////////
  Future<void> tvseriesfunction() async {
   populartvseries = await fetchContent(
       popularseriesurl,'tv');
  topratedtvseries = await fetchContent(
      topratedtvurl,'tv');
  comedytvseries = await fetchContent(
      comedytvurl,'tv');
  actiontvseries = await fetchContent(
      actiontvurl,'tv');
   upcomingtvseries = await fetchContent(
       upcomingtvseriesurl,'tv');
  /////////////////////////////////////////////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: tvseriesfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sliderlist(populartvseries, "popular tv series", "tv", 20),
                  sliderlist(topratedtvseries, "top rated tv series", "tv", 20),
                  sliderlist(comedytvseries, "comedy", "tv", 20),
                  sliderlist(actiontvseries, "action", "tv", 20),
                  sliderlist(upcomingtvseries, "on air", "tv", 20),
                ],
              ),
            );
          }
        });
  }
}
