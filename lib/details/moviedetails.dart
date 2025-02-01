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



class MovieDetails extends StatefulWidget {
  var id;
  MovieDetails({this.id});
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<Map<String, dynamic>> MovieDetails = [];
  List<Map<String, dynamic>> UserREviews = [];
  List<Map<String, dynamic>> similarmovieslist = [];
  List<Map<String, dynamic>> recommendedmovieslist = [];

  List MoviesGeneres = [];

  Future Moviedetails() async {
    var moviedetailurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '?api_key=$apikey';
    var UserReviewurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/reviews?api_key=$apikey';
    var similarmoviesurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/similar?api_key=$apikey';
    var recommendedmoviesurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/recommendations?api_key=$apikey';


    try {
      var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
      if (moviedetailresponse.statusCode == 200) {
        var moviedetailjson = jsonDecode(moviedetailresponse.body);
        for (var i = 0; i < 1; i++) {
          MovieDetails.add({
            "backdrop_path": moviedetailjson['backdrop_path'],
            "title": moviedetailjson['title'],
            "vote_average": moviedetailjson['vote_average'],
            "overview": moviedetailjson['overview'],
            "release_date": moviedetailjson['release_date'],
            "runtime": moviedetailjson['runtime'],
            "budget": moviedetailjson['budget'],
            "revenue": moviedetailjson['revenue'],
            "poster_path": moviedetailjson['poster_path'],
          });
        }
        for (var i = 0; i < moviedetailjson['genres'].length; i++) {
          MoviesGeneres.add(moviedetailjson['genres'][i]['name']);
        }
      }
    } catch (e) {
      print("Error fetching movie details: $e");
    }

    /////////////////////////////User Reviews///////////////////////////////
    try {
      var UserReviewresponse = await http.get(Uri.parse(UserReviewurl));
      if (UserReviewresponse.statusCode == 200) {
        var UserReviewjson = jsonDecode(UserReviewresponse.body);
        for (var i = 0; i < UserReviewjson['results'].length; i++) {
          UserREviews.add({
            "name": UserReviewjson['results'][i]['author'],
            "review": UserReviewjson['results'][i]['content'],
            //check rating is null or not
            "rating": UserReviewjson['results'][i]['author_details']['rating'] == null
                ? "Not Rated"
                : UserReviewjson['results'][i]['author_details']['rating']
                .toString(),
            "avatarphoto": UserReviewjson['results'][i]['author_details']
            ['avatar_path'] ==
                null
                ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
                : "https://image.tmdb.org/t/p/w500" +
                UserReviewjson['results'][i]['author_details']['avatar_path'],
            "creationdate": UserReviewjson['results'][i]['created_at'].substring(0, 10),
            "fullreviewurl": UserReviewjson['results'][i]['url'],
          });
        }
      }
    } catch (e) {
      print("Error fetching user reviews: $e");
    }

    /////////////////////////////similar movies///////////////////////////////
    similarmovieslist = await
    fetchContent(similarmoviesurl, 'movie');

    /////////////////////////////recommended movies///////////////////////////////
    recommendedmovieslist = await
    fetchContent(recommendedmoviesurl, 'movie');

  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: FutureBuilder(
        future: Moviedetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
                      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
                          image: NetworkImage('https://image.tmdb.org/t/p/w500' + MovieDetails[0]['poster_path']),
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
                            'https://image.tmdb.org/t/p/w500' + MovieDetails[0]['poster_path'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),


                ),
                SliverList(delegate: SliverChildListDelegate([

                  Column(
                    children: [
                      Row(children: [
                        Container(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: MoviesGeneres.length,
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
                                      genrestext(MoviesGeneres[index]));
                                })),
                      ]),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 10, top: 10),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: genrestext(
                                  MovieDetails[0]['runtime'].toString() +
                                      ' min'))
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: boldtext(MovieDetails[0]['title']),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: tittletext('Movie Story :')),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: overviewtext(
                          MovieDetails[0]['overview'].toString())),

                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: ReviewUI(revdeatils: UserREviews),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: normaltext('Release Date : ' +
                          MovieDetails[0]['release_date'].toString())),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: normaltext('Budget : ' +
                          MovieDetails[0]['budget'].toString())),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: normaltext('Revenue : ' +
                          MovieDetails[0]['revenue'].toString())),
                  sliderlist(similarmovieslist, "Similar Movies", "movie",
                      20),
                  sliderlist(recommendedmovieslist, "Recommended Movies",
                      "movie", 20),

                ]))
              ]);
          } else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      ),
    );
  }
}
