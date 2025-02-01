import 'package:flutter/material.dart';
import 'package:movie_tracker/repeted/slider.dart';
import 'package:movie_tracker/repeted/fetchlist.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {

  List<Map<String, dynamic>> upcomingmovie = [];
  List<Map<String, dynamic>> upcomingtvseries = [];


  //////////////////////////////////////////////////////////////////

  String upcomingmovieurl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=1c08fd61d20a1d3754bd70c470d80cb9';
  var upcomingtvseriesurl =
      'https://api.themoviedb.org/3/discover/tv?api_key=1c08fd61d20a1d3754bd70c470d80cb9&language=en-US&sort_by=first_air_date.asc&first_air_date.gte=2024-12-26&page=1';

  ////////////////////////////////////////////////////////////////////////7

  Future<void> othersfunction() async {

    upcomingmovie = await fetchContent(
        upcomingmovieurl , 'others');
    upcomingtvseries = await fetchContent(
        upcomingtvseriesurl , 'others');

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: othersfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sliderlist(upcomingmovie, "upcoming movies", "movie", 20),
                  sliderlist(upcomingtvseries, "upcoming tv series", "tv series", 20),
                ],
              ),
            );
          }
        });
  }
}
