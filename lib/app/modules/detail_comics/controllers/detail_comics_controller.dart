import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:komikzone/app/data/model/details.dart';

class DetailComicsController extends GetxController {
  Future<Details> getDetailsComics(String param) async {
    final response =
        await http.get(Uri.parse('https://wibutools.live/api/komiku/$param'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body)["data"];
      return Details.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch comic details');
    }
  }
}
