import 'package:movie_tracker/details/moviedetails.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/details/tvseriesdetails.dart';

import '../colors.dart';


Widget sliderlist(List firstlistname, String categorytitle, String type, int itemcount) {
  // Eğer liste boşsa, boş bir Container döndür.
  if (firstlistname.isEmpty) {
    return SizedBox.shrink(); // Hiçbir şey göstermeyen bir widget
  }

  // Liste doluysa, sliderlist yapısını döndür.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
          child: Text(categorytitle.toString(),
              style: TextStyle(
                  color: butter, fontSize: 18, fontWeight: FontWeight.bold))),
      Container(
          height: 250,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: itemcount,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (type == 'movie') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                id: firstlistname[index]['id'],
                              )));
                    } else if (type == 'tv') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TvDetails(
                                id: firstlistname[index]['id'],
                              )));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken),
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${firstlistname[index]['poster_path']}'),
                            fit: BoxFit.cover)),
                    margin: const EdgeInsets.only(left: 13),
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                            const EdgeInsets.only(top: 8, left: 6),
                            child: Text(
                              firstlistname[index]['date'],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 15,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    firstlistname[index]['vote_average']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
      SizedBox(height: 20),
    ],
  );
}
