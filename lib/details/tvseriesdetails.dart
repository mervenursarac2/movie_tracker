import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_tracker/colors.dart';
import 'package:movie_tracker/repeted/fetchlist.dart';
import '../api_key/api_key.dart';
import 'package:movie_tracker/repeted/repttext.dart';
import 'package:movie_tracker/repeted/slider.dart';
import 'package:movie_tracker/HomePage/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_tracker/repeted/ReviewUI.dart';


class TvDetails extends StatefulWidget {
  final int id;
  TvDetails({required this.id});

  @override
  State<TvDetails> createState() => _TvDetailsState();
}

class _TvDetailsState extends State<TvDetails> {
  List<Map<String, dynamic>> tvDetails = [];
  List<Map<String, dynamic>> userReviews = [];
  List<Map<String, dynamic>> similarTvList = [];
  List<Map<String, dynamic>> recommendedTvList = [];
  List<String> tvGenres = [];

  Future fetchTvDetails() async {
    var tvDetailUrl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '?api_key=$apikey';
    var userReviewUrl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '/reviews?api_key=$apikey';
    var similarTvUrl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '/similar?api_key=$apikey';
    var recommendedTvUrl = 'https://api.themoviedb.org/3/tv/' +
        widget.id.toString() +
        '/recommendations?api_key=$apikey';

    try {
      var tvDetailResponse = await http.get(Uri.parse(tvDetailUrl));
      if (tvDetailResponse.statusCode == 200) {
        var tvDetailJson = jsonDecode(tvDetailResponse.body);
        tvDetails.add({
          "backdrop_path": tvDetailJson['backdrop_path'],
          "name": tvDetailJson['name'],
          "vote_average": tvDetailJson['vote_average'],
          "overview": tvDetailJson['overview'],
          "first_air_date": tvDetailJson['first_air_date'],
          "number_of_seasons": tvDetailJson['number_of_seasons'],
          "number_of_episodes": tvDetailJson['number_of_episodes'],
          "poster_path": tvDetailJson['poster_path'],
        });
        for (var genre in tvDetailJson['genres']) {
          tvGenres.add(genre['name']);
        }
      }
    } catch (e) {
      print("Error fetching TV details: $e");
    }

    try {
      var userReviewResponse = await http.get(Uri.parse(userReviewUrl));
      if (userReviewResponse.statusCode == 200) {
        var userReviewJson = jsonDecode(userReviewResponse.body);
        for (var review in userReviewJson['results']) {
          userReviews.add({
            "name": review['author'],
            "review": review['content'],
            "rating": review['author_details']['rating']?.toString() ?? "Not Rated",
            "avatarphoto": review['author_details']['avatar_path'] == null
                ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
                : "https://image.tmdb.org/t/p/w500" + review['author_details']['avatar_path'],
            "creationdate": review['created_at'].substring(0, 10),
            "fullreviewurl": review['url'],
          });
        }
      }
    } catch (e) {
      print("Error fetching user reviews: $e");
    }

    similarTvList = await fetchContent(similarTvUrl, 'tv');
    recommendedTvList = await fetchContent(recommendedTvUrl, 'tv');
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: FutureBuilder(
        future: fetchTvDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(FontAwesomeIcons.arrowLeft),
                    iconSize: 28,
                    color: butter,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                              (route) => false,
                        );
                      },
                      icon: Icon(FontAwesomeIcons.houseUser),
                      iconSize: 25,
                      color: butter,
                    ),
                  ],
                  backgroundColor: darkColor,
                  centerTitle: false,
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500' + tvDetails[0]['poster_path']),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 2 / 3, // Posterlerin genellikle 2:3 oranında olması için.
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500' + tvDetails[0]['poster_path'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tvGenres.length,
                                    itemBuilder: (context, index) {
                                      //generes box
                                      return Container(
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: butter,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child:
                                          genrestext(tvGenres[index]));
                                    })),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: boldtext(tvDetails[0]['name']),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: tittletext('Story:'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: overviewtext(tvDetails[0]['overview']),
                    ),
                    sliderlist(similarTvList, "Similar TV Shows", "tv", 20),
                    sliderlist(recommendedTvList, "Recommended TV Shows", "tv", 20),
                  ]),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
