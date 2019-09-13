import 'dart:convert';

import 'package:fluttertube/shared/models/video-model.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyAq1w2vEfkEHVfbRSYJOaAot4RSvNm5My4";

class ApiYouTube {

  String _search;
  String _nextToken;

  Future<List<VideoModel>> search(String search) async {
    _search = search;

    String url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10";

    http.Response response = await http.get(url);
    return decode(response);
  }

  Future<List<VideoModel>> nextPage() async {
    String url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken";

    http.Response response = await http.get(url);
    return decode(response);
  }
  Future<List> getSuggestionsFromYoutube(String search) async {
    http.Response response = await http.get(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json");

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((res) {
        return res[0];
      }).toList();
    } else {
      throw Exception("Erro ao carregar as sugestões!");
    }
  }

  List<VideoModel> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      List<VideoModel> videos = decoded["items"].map<VideoModel>((video) {
        return VideoModel.fromJson(video);
      }).toList();

      return videos;
    } else {
      throw Exception("Falha ao carregar os vídeos!");
    }
  }

}
