import 'package:http/http.dart' as http;
import 'http_methods.dart';

class APIComm {
  static List<dynamic> cache = [];

  static Future getData(String url) async {
    try {
      if (!APIComm.cache.isNotEmpty) {
        cache.add(await httpFetch(url));
      }
    } catch (e) {}
  }
}
