import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/api_response_model.dart';
import 'dart:convert';
import 'package:my_taraji/views/home/components/news/models/news_models.dart';

class NewsService {
  late String baseUrl = "https://devmytarajiapi.azurewebsites.net";
  NewsService();

  Future<APIResponseModel<List<News>>> getAllNews() async {
    const path = "api/v1/news";
    final url = Uri.parse('$baseUrl/$path');

    try {
      var response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);

      try {
        return APIResponseModel<List<News>>.fromJson(
          jsonData,
          (data) => fromJsonListNews(data),
        );
      } catch (e) {
        throw Exception('fromJsonListNews error : $e');
      }
    } catch (e) {
      throw Exception('getAllNews from Service error : $e');
    }
  }

  Future<APIResponseModel<News>> getNewsById(String id) async {
    const path = "api/v1/news";
    final url = Uri.parse('$baseUrl/$path/$id');

    try {
      final response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      try {
        return APIResponseModel<News>.fromJson(
          jsonData,
          (data) => News.fromJson(data),
        );
      } catch (e) {
        throw Exception('fromJsonListNews error : $e');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server for news data by id $e');
    }
  }
}
