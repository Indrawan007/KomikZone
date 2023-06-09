import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:komikzone/app/data/model/comics.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Future<List<Comics>> getAllComics() async {
    final response = await http.get(
      Uri.parse('https://wibutools.live/api/komiku'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>)["data"];
      print(data);
      return data.map((json) => Comics.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch comics');
    }
  }
}
