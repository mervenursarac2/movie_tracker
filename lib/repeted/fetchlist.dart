import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchContent(String url, String type) async {
  List<Map<String, dynamic>> contentList = [];

  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var tempData = jsonDecode(response.body);
      var contentJson = tempData['results'];

      for (var content in contentJson) {
        contentList.add({
          "name": content[type == "movie" ? "title" : "name"] ?? "Unknown Title",
          "poster_path": content["poster_path"],
          "vote_average": content["vote_average"].toStringAsFixed(1) ?? 0.0,
          "date": content[type == "movie" ? "release_date" : "first_air_date"] ?? "Date Unknown",
          "id": content["id"],
        });
      }
    } else {
      print("Failed to fetch data from $url. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred while fetching data: $e");
  }

  return contentList;
}
