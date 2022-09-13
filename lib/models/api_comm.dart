import 'http_methods.dart';

class APIComm {
  static List<dynamic> cache = [];

  static Future getData(String url, key) async {
    try {
      if (APIComm.cache.isEmpty || !APIComm.cache.contains(key)) {
        cache.add(key);
        cache.add(await httpFetch(url));
      }
    } catch (e) {}
  }
}
