import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/app_strings.dart';

class ApiServices {
  // get  users data...
  Future<List<dynamic>> fetchData(int pageNum) async {
    String url = apiUserUrl;

    final uri = Uri.parse(
      url,
    ).replace(queryParameters: {'per_page': '10', 'page': pageNum.toString()});

    final response = await http
        .get(uri, headers: {"x-api-key": headerApiKeyValue})
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['data'];
    } else {
      throw Exception("Failed to fetch Data");
    }
  }

  // get the Searched User...
  Future<List<dynamic>> searchedData() async {
    String url = apiUserUrl;

    final uri1 = Uri.parse(
      url,
    ).replace(queryParameters: {'per_page': '10', 'page': "1"});
    final uri2 = Uri.parse(
      url,
    ).replace(queryParameters: {'per_page': '10', 'page': "2"});

    final response1 = await http
        .get(uri1, headers: {"x-api-key": headerApiKeyValue})
        .timeout(const Duration(seconds: 10));
    final response2 = await http
        .get(uri2, headers: {"x-api-key": headerApiKeyValue})
        .timeout(const Duration(seconds: 10));

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      final List<dynamic> data1 = jsonDecode(response1.body)['data'];
      final List<dynamic> data2 = jsonDecode(response2.body)['data'];

      final allUsers = [...data1, ...data2];

      return allUsers;
    } else {
      throw Exception("Failed to search Data");
    }
  }
}
