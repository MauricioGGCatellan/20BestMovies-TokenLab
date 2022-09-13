import 'dart:convert';

import '../models/api_comm.dart';

class MoviepageModel {
  int id;
  late String title;
  late String posterUrl;
  late String releaseDate;
  late double voteAverage;
  late String tagline;
  late String overview;

  String _url = 'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2';

  _updateFields(info) {
    var jsonObj = jsonDecode(info);
    title = jsonObj['title'];
    posterUrl = jsonObj['poster_url'];
    releaseDate = jsonObj['release_date'];
    voteAverage = jsonObj['vote_average'];
    tagline = jsonObj['tagline'];
    overview = jsonObj['overview'];
  }

  Future requestData() async {
    if (!APIComm.cache.contains(id)) {
      await APIComm.getData(_url, id);
    }

    var info = APIComm.cache[APIComm.cache.indexOf(id) + 1];
    _updateFields(info);
  }

  MoviepageModel(this.id) {
    _url = '$_url/$id';
  }
}
