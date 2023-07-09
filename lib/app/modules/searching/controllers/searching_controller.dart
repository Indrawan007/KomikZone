import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:komikzone/app/data/model/comics.dart';

class SearchingController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Comics> searchResults = RxList<Comics>();
  RxBool isLoading = false.obs;

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    final apiUrl = 'https://wibutools.live/api/komiku';

    try {
      final response = await http.get(Uri.parse('$apiUrl=judul?$query'));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<Comics> comics = List<Comics>.from(
            jsonResponse.map((data) => Comics.fromJson(data)));
        searchResults.assignAll(comics);
      } else {
        throw Exception('Failed to search books');
      }
    } catch (e) {
      print('Failed to search books: $e');
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
