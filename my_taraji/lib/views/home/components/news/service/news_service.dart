import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_taraji/views/home/components/news/models/news_models.dart';

class NewsService {
  late String baseUrl = "https://devmytarajiapi.azurewebsites.net";
  NewsService();

  Future<List<News>> getAllNews() async {
    const path = "api/v1/news";
    final url = Uri.parse('$baseUrl/$path');

    try {
      var response = await http.get(url);
      final List<dynamic> jsonData = json.decode(response.body);
      try {
        return fromJsonListNews(jsonData);
      } catch (e) {
        throw Exception('fromJsonListNews error : $e');
      }
    } catch (e) {
      throw Exception('getAllNews from Service error : $e');
    }
  }

  Future<News> getNewsById(int id) async {
    const path = "api/v1/news";
    final url = Uri.parse('$baseUrl/$path/$id');

    try {
      final response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      try {
        News news = News.fromJson(jsonData);
        return news;
      } catch (e) {
        throw Exception('fromJsonListNews error : $e');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server for news data by id $e');
    }
  }
}
