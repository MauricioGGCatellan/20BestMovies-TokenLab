import 'package:http/http.dart' as http;

class APIComm {
  static var cache = [];

  static Future<String> httpFetch(String url) async {
    var urlParse = Uri.parse(url);
    var response = await http.get(urlParse);

    if (!cache.contains(response.body)) {
      cache.add(response.body);
    }

    return response.body;
  }
}
