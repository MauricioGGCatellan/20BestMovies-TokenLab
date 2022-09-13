import 'dart:convert';

import '../models/api_comm.dart';
import '../models/http_methods.dart';

class HomepageModel {
  List<int> ids = [];
  List<String> titles = [];
  List<String> posterUrls = [];

  String _url = 'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2';

  _updateFields(info) {
    var jsonList = jsonDecode(info);
    for (var jsonObj in jsonList) {
      ids.add(jsonObj['id']);
      titles.add(jsonObj['title']);
      posterUrls.add(jsonObj['poster_url']);
    }
  }

  Future requestData() async {
    if (APIComm.cache.isEmpty) {
      await APIComm.getData(_url);
    }
    _updateFields(APIComm.cache[0]);
  }

  /*HomepageModel() {
    if (APIComm.cache.isNotEmpty) {
      _updateFields(APIComm.cache[0]);
    } 
  }*/
}
