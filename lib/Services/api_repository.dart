import 'dart:io';

import 'package:demo_app/Services/http_service.dart';
import 'package:demo_app/models/dictionary_model.dart';
import 'package:http/http.dart';

class WordRepository {
  Future<List<Dictionary>> getWordsFromDictionary(String query) async {
    try {
      print(query);
      Response response = await HttpService.getRequest('en_US/$query');
      print(response);
      // final response = await HttpService.getRequest('en_US/$query');
      if (response.statusCode == 200) {
        final result = dictionaryFromJson(response.body);
        return result;
      } else {
        print("response status is not 200");
        List<Dictionary> result = [];
        return result;
      }
    } on SocketException catch (e) {
      print("SocketException $e");

      rethrow;
    } on HttpException catch (e) {
      print("HttpException $e");

      rethrow;
    } on FormatException catch (e) {
      print("FormatException $e");

      rethrow;
    }
  }
}
