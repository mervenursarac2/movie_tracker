import 'dart:convert'; // json işlemleri için kullanıldı

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http istekleri ve yanıtları
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_tracker/HomePage/Sections/Upcoming.dart';
import 'package:movie_tracker/allapilinks/allapi.dart';
import 'package:movie_tracker/colors.dart'; //api bağantılarını içeren dosya
//import 'package:movie_tracker/api_key/api_key.dart';
import 'package:movie_tracker/HomePage/Sections/Upcoming.dart';
import 'package:movie_tracker/HomePage/Sections/Movies.dart';
import 'package:movie_tracker/HomePage/Sections/TvSeries.dart';
import 'package:movie_tracker/repeted/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  List<Map<String, dynamic>> trendinglist = []; // trend filmleri tutan liste

  //API'den haftalık trend filmleri çeken fonksiyon
  Future<void> trendinglisthome() async {
    if (uval == 1) {
      var trendingweekresponse = await http.get(
          Uri.parse(trendingweekmovieurl)); // get isteği gönderir ve yanıtı alır
      print(
          "Response status: ${trendingweekresponse.statusCode}"); // Yanıt durumu
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var trendingweekjson = tempdata['results'];
        //print("Data received: $trendingweekjson"); // Veriyi konsola yazdır
        for (var i = 0; i < trendingweekjson.length; i++) {
          trendinglist.add({
            'id': trendingweekjson[i]['id'],
            'poster_path': trendingweekjson[i]['poster_path'],
            'vote_average': trendingweekjson[i]['vote_average'],
            'media_type': trendingweekjson[i]['media_type'],
            'indexno': i,
          });
        }
      } else {
        print(
            "Failed to load data. Status code: ${trendingweekresponse.statusCode}");
      }
    } else if (uval == 2) {
      var trendingweekurl =
          'https://api.themoviedb.org/3/trending/movie/day?api_key=1c08fd61d20a1d3754bd70c470d80cb9';
      var trendingweekresponse = await http
          .get(Uri.parse(trendingdaymovieurl)); // get isteği gönderir ve yanıtı alır
      print(
          "Response status: ${trendingweekresponse.statusCode}"); // Yanıt durumu
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var trendingweekjson = tempdata['results'];
        //print("Data received: $trendingweekjson"); // Veriyi konsola yazdır
        for (var i = 0; i < trendingweekjson.length; i++) {
          trendinglist.add({
            'id': trendingweekjson[i]['id'],
            'poster_path': trendingweekjson[i]['poster_path'],
            'vote_average': trendingweekjson[i]['vote_average'],
            'media_type': trendingweekjson[i]['media_type'],
            'indexno': i,
          });
        }
      } else {
        print(
            "Failed to load data. Status code: ${trendingweekresponse.statusCode}");
      }
    }
  }

  int uval = 1;
  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            /*image: DecorationImage(
            image: AssetImage('assets/images/mainBG.png'),
            fit: BoxFit.cover, // Arka planın tüm alanı kaplamasını sağlar.
          ),*/
          color: darkColor,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              toolbarHeight: 60,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: FutureBuilder(
                    future: trendinglisthome(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          color: darkColor,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 0.6, // Poster genişliğini düzenler
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              enlargeCenterPage: true, // Ortadaki posteri büyütür
                              aspectRatio: 2 / 3, // Posterlerin boyut oranını ayarlar

                            ),
                            items: trendinglist.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Detay ekranına yönlendirme veya işlem eklenebilir
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 6,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500${i['poster_path']}',
                                          ),
                                          fit: BoxFit.contain, // Görüntünün orijinal boyutunu korur
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );


                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "trending",
                    style: TextStyle(
                        color: butter.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: 'PlaywriteGBS',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 45,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton(
                          items: [
                            DropdownMenuItem(
                                child: Text('weekly',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: butter,
                                        fontSize: 16)),
                                value: 1),
                            DropdownMenuItem(
                                child: Text('daily',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: butter,
                                        fontSize: 16)),
                                value: 2)
                          ],
                          icon: Icon(
                            Icons.arrow_drop_down_sharp,
                            color: darkColor,
                            size: 30,
                          ),
                          autofocus: true,
                          value: uval,
                          onChanged: (value) {
                            setState(() {
                              trendinglist.clear();
                              uval = int.parse(value.toString());
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  searchbar(),
                  Container(
                    height: 45, width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      controller: _tabController,
                        physics: BouncingScrollPhysics(),
                        isScrollable: false,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: mainColor),
                        tabs:[
                          Tab(child: Text('tv series',style: TextStyle(color: butter,
                              fontFamily: 'PlaywriteGBS',
                              fontWeight: FontWeight.bold ),),),
                          Tab(child: Text('movies',style: TextStyle(color: butter,
                              fontFamily: 'PlaywriteGBS',
                              fontWeight: FontWeight.bold),),),
                          Tab(child: Text('up coming',style: TextStyle(color: butter,
                              fontFamily: 'PlaywriteGBS',
                              fontWeight: FontWeight.bold),),)
                        ],),
                  ),
                  Container(
                    height: 1050,
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        Tvseries(),
                        Movies(),
                        Upcoming(),
                      ],
                    ),
                  ),

            ]))
          ],
        ),
      ),
    );
  }
}
