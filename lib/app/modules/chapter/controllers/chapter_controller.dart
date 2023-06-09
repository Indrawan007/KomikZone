import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:komikzone/app/data/model/allchapters.dart';

class ChapterController extends GetxController {
  Future<AllChapters> getAllChapters(String param) async {
    final response = await http.get(
      Uri.parse('https://wibutools.live/api/komiku/chapter/$param'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      return AllChapters.fromJson(data);
    } else {
      throw Exception('Failed to fetch comic chapters');
    }
  }
}
