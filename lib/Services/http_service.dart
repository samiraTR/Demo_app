import 'package:http/http.dart' as http;

class HttpService {
  static const baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/";

  static Future<http.Response> getRequest(endPoint) async {
    http.Response response;

    final url = Uri.parse("$baseUrl$endPoint");

    try {
      response = await http.get(url);
      print('response.body: ${response.body}');
    } on Exception catch (e) {
      print(e);

      rethrow;
    }
    print("response from http service: ${response.body.length}");
    return response;
  }
}
