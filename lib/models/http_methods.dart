import 'package:http/http.dart' as http;

Future<dynamic> httpFetch(String url) async {
  var urlParse = Uri.parse(url);
  var responseFull = await http.get(urlParse);
  String response = responseFull.body;

  return response;
}
