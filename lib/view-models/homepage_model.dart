import 'dart:convert';

import '../models/api_comm.dart';

class HomepageModel {
  final listId = 0;
  List<int> ids = [];
  List<String> titles = [];
  List<String> posterUrls = [];

  final String _url =
      'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2';

  _updateFields(info) {
    print(info);
    var jsonList = jsonDecode(info);

    for (var jsonObj in jsonList) {
      ids.add(jsonObj['id']);
      titles.add(jsonObj['title']);
      posterUrls.add(jsonObj['poster_url']);
    }
  }

  Future requestData() async {
    if (!APIComm.cache.contains(listId)) {
      await APIComm.getData(_url, listId);
    }

    var info = APIComm.cache[APIComm.cache.indexOf(listId) + 1];

    _updateFields(info);
  }
}
