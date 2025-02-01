import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:movie_tracker/api_key/api_key.dart';
import 'package:movie_tracker/repeted/fetchlist.dart';
import 'package:movie_tracker/repeted/repttext.dart';

import '../colors.dart';
import '../details/checker.dart';

class searchbar extends StatefulWidget {
  const searchbar({super.key});

  @override
  State<searchbar> createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  final TextEditingController searchText = TextEditingController();
  bool showList = false;
  var val1;

  List<Map<String, dynamic>> searchResult = [];

  Future<void> searchbarfunc(String val) async {
    var searchurl =
        'https://api.themoviedb.org/3/search/multi?api_key=$apikey&query=$val';
    try {
      var searchResponse = await http.get(Uri.parse(searchurl));
      if (searchResponse.statusCode == 200) {
        var tempData = jsonDecode(searchResponse.body);
        var searchjson = tempData['results'];

        for (var i = 0; i < searchjson.length; i++) {
          if (searchjson[i]['id'] != null &&
              searchjson[i]['poster_path'] != null &&
              searchjson[i]['vote_average'] != null &&
              searchjson[i]['media_type'] != null &&
              searchjson[i]['title'] != null) {
            searchResult.add({
              'id': searchjson[i]['id'],
              'poster_path': searchjson[i]['poster_path'],
              'vote_average': searchjson[i]['vote_average'],
              'media_type': searchjson[i]['media_type'],
              'popularity': searchjson[i]['popularity'],
              'overview': searchjson[i]['overview'],
              'title': searchjson[i]['title'],
            });
            if (searchResult.length > 20) {
              searchResult.removeRange(20, searchResult.length);
            } else {
              print("null value found");
            }
          }
        }
      } else {
        print(
            "Failed to fetch data from $searchurl. Status code: ${searchResponse.statusCode}");
      }
    } catch (e) {
      print("An error occurred while fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showList = !showList;
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 30, bottom: 20, right: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: butter.withOpacity(1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                autofocus: false,
                controller: searchText,
                onSubmitted: (value) {
                  searchResult.clear();
                  setState(() {
                    val1 = value;
                  });
                },
                onChanged: (value) {
                  searchResult.clear();
                  setState(() {
                    val1 = value;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          webBgColor: "#000000",
                          webPosition: "center",
                          webShowClose: true,
                          msg: "Search Cleared",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: darkColor,
                          textColor: butter,
                          fontSize: 16.0);
                      setState(() {
                        searchText.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: darkColor,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: darkColor,
                  ),
                  hintText: 'search',
                  hintStyle: TextStyle(color: mainColor),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 5),
            searchText.text.length > 0
                ? FutureBuilder(
                    future: searchbarfunc(val1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                            height: 400,
                            child: ListView.builder(
                                itemCount: searchResult.length,
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    descriptioncheckui(
                                                      newid: searchResult[index]['id'],
                                                      newtype: searchResult[index]['media_type'],
                                                    )));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 4, bottom: 4),
                                          height: 180,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color:
                                                  mainColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Row(
                                              children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://image.tmdb.org/t/p/w500${searchResult[index]['poster_path']}'),
                                                      fit: BoxFit.fill)),
                                            ),
                                                SizedBox(width: 20),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        searchResult[index]['title'] ?? "",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            'Rating: ${searchResult[index]['vote_average'].toString()}',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          ])));
                                }));
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.amber,
                        ));
                      }
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}
