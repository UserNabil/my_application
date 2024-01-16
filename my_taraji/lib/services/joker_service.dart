import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/joker_request.dart';

class JokerService {
  late String baseUrl = "http://localhost:5074";
  JokerService();

  Future<String> useJoker(JokerRequest answer, int joker) async {
    const path = "api/v1/challenge-answers/use-jokers";
    final url = Uri.parse('$baseUrl/$path/$joker');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(answer.toMap()),
      );
      if (response.statusCode == 200) {
        try {
          String responseAnswer = response.body;
          return responseAnswer;
        } catch (e) {
          throw Exception('fromJsonAnswerJokerResponse error : $e');
        }
      } else {
        throw Exception('Failed to submit joker - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for submitting joker $e');
    }
  }
}
