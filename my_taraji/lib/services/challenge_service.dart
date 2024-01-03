import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/challenge_model.dart';

class ChallengeService {
  late String baseUrl = "http://localhost:5074";
  ChallengeService();

  Future<List<Challenge>> getAllChallenges() async {
    const path = "api/v1/challenges?Page=0&Limit=10";
    final url = Uri.parse('$baseUrl/$path');
    List<Challenge> challenges = [];

    try {
      var response = await http.get(url);
      final dynamic jsonData = json.decode(response.body);
      challenges = fromJsonListChallenge(jsonData['data']);
      return challenges;
    } catch (e) {
      throw Exception('Failed to connect to the server for challenge data $e');
    }
  }
}
