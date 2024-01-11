import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/challenge_answer_request_model.dart';
import 'package:my_taraji/core/models/challenge_by_id_model.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/leader_bord_result.dart';
import 'package:my_taraji/core/models/next_question_model.dart';

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

  Future<ChallengeQuestionResult> getNextQuestionByStepId(String stepid) async {
    const path = "api/v1/challenges/next-question";
    final url = Uri.parse('$baseUrl/$path/$stepid');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        ChallengeQuestionResult nextQuestion =
            ChallengeQuestionResult.fromJson(jsonData);
        return nextQuestion;
      } else {
        throw Exception('Failed to load next question data');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for next question data by step id $e');
    }
  }

  Future<String> submitChallengeAnswers(
      ChallengeAnswerRequest answer, String stepid) async {
    const path = "api/v1/challenge-answers";
    final url = Uri.parse('$baseUrl/$path/$stepid');

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
          throw Exception('fromJsonAnswerChallengeResponse error : $e');
        }
      } else {
        throw Exception(
            'Failed to submit challenge answers - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for submitting challenge answers $e');
    }
  }

  Future<ChallengeById> getChallengeById(String challengeid) async {
    const path = "api/v1/challenges";
    final url = Uri.parse('$baseUrl/$path/$challengeid');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        ChallengeById challenge = ChallengeById.fromJson(jsonData);

        return challenge;
      } else {
        throw Exception('Failed to load challenge data by id');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for challenge data by id $e');
    }
  }

  Future<LeaderBordResult> getLeaderBordInfoByChallengeId(
      String challengeid) async {
    const path = "api/v1/challenges/leader-board";
    final url = Uri.parse('$baseUrl/$path/$challengeid');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        LeaderBordResult leaderbord = LeaderBordResult.fromJson(jsonData);

        return leaderbord;
      } else {
        throw Exception('Failed to load leader bord data by challenge id');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for leader bord data by challenge id $e');
    }
  }
}
