import 'dart:convert';

import '../models/api_comm.dart';

class HomepageModel {
  var ids = <int>[];
  var titles = <String>[];
  var posterUrls = <String>[];

  // ignore: prefer_typing_uninitialized_variables
  var _jsonList;
  // ignore: prefer_final_fields
  String _url = 'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2';

  Future _comm() async {
    try {
      var response = await APIComm.httpFetch(_url);
      _jsonList = jsonDecode(response);
    } catch (e) {
      _jsonList = -1;
    }
  }

  HomepageModel() {
    if (APIComm.cache.isNotEmpty) {
      _jsonList = jsonDecode(APIComm.cache[0]);
    } else {
      _comm();
    }

    for (var jsonObj in _jsonList) {
      ids.add(jsonObj['id']);
      titles.add(jsonObj['title']);
      posterUrls.add(jsonObj['poster_url']);
    }
  }
}
