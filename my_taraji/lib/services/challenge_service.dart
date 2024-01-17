import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/api_response_model.dart';
import 'package:my_taraji/core/models/challenge_answer_request_model.dart';
import 'package:my_taraji/core/models/challenge_answer_response_model.dart';
import 'package:my_taraji/core/models/challenge_by_id_model.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/leader_bord_result.dart';
import 'package:my_taraji/core/models/next_question_model.dart';

class ChallengeService {
  late String baseUrl = "https://devmytarajiapi.azurewebsites.net";
  ChallengeService();

  Future<APIResponseModel<List<Challenge>>> getAllChallenges() async {
    const path = "api/v1/challenges?Page=0&Limit=10";
    final url = Uri.parse('$baseUrl/$path');
    try {
      var response = await http.get(url);
      final dynamic jsonData = json.decode(response.body);
      return APIResponseModel<List<Challenge>>.fromJson(
        jsonData,
        (data) => fromJsonListChallenge(data['data']),
      );
    } catch (e) {
      throw Exception('Failed to connect to the server for challenge data $e');
    }
  }

  Future<APIResponseModel<ChallengeQuestionResult>> getNextQuestionByStepId(
      String stepid) async {
    const path = "api/v1/challenges/next-question";
    final url = Uri.parse('$baseUrl/$path/$stepid');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        APIResponseModel<ChallengeQuestionResult> nextQuestion =
            APIResponseModel<ChallengeQuestionResult>.fromJson(
                jsonData, (data) => ChallengeQuestionResult.fromJson(data));
        return nextQuestion;
      } else {
        throw Exception('Failed to load next question data');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for next question data by step id $e');
    }
  }

  Future<APIResponseModel<ChallengeAnswerResponse>> submitChallengeAnswers(
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
          print('response.body ${response.body}');
          final Map<String, dynamic> jsonData = json.decode(response.body);
          APIResponseModel<ChallengeAnswerResponse> responseanswer =
              APIResponseModel<ChallengeAnswerResponse>.fromJson(
                  jsonData, (data) => ChallengeAnswerResponse.fromJson(data));
          return responseanswer;
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

  Future<APIResponseModel<ChallengeById>> getChallengeById(
      String challengeid) async {
    const path = "api/v1/challenges";
    final url = Uri.parse('$baseUrl/$path/$challengeid');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("challenge id response ${response.body}");
        final Map<String, dynamic> jsonData = json.decode(response.body);

        APIResponseModel<ChallengeById> challenge =
            APIResponseModel<ChallengeById>.fromJson(
                jsonData, (data) => ChallengeById.fromJson(data));
        return challenge;
      } else {
        throw Exception('Failed to load challenge data by id');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for challenge data by id $e');
    }
  }

  Future<APIResponseModel<LeaderBordResult>> getLeaderBordInfoByChallengeId(
      String challengeid) async {
    const path = "api/v1/challenges/leader-board";
    final url = Uri.parse('$baseUrl/$path/$challengeid');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        APIResponseModel<LeaderBordResult> leaderbord =
            APIResponseModel<LeaderBordResult>.fromJson(
                jsonData, (data) => LeaderBordResult.fromJson(data));

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
