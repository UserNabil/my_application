import 'dart:developer';

import 'package:my_taraji/core/api/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_taraji/views/home/models/crowdfunding_output.dart';

Future<CrowdfundingOutput> getCrowdfundingList() async {
  final url = Uri.parse(urlCrowdFundingList);
  Map<String, dynamic> parameters = {
    'Page': '10',
    'Limit': '0',
  };
  try {
    Uri uriWithParams = Uri.https(url.authority, url.path, parameters);
    log('uri withparams $uriWithParams');

    final response = await http.get(uriWithParams);
    log('response : ${response.body}');
    final data = json.decode(response.body);
    log('data $data');
    final CrowdfundingOutput crowdfundingOutput =
        CrowdfundingOutput.fromJson(data);
    log(crowdfundingOutput.toString());
    return crowdfundingOutput;
  } catch (e) {
    throw Exception(
      'Failed to connect to the server to get getCrowdfundingList',
    );
  }
}

Future<CrowdfundingOutput> getCrowdfundingDetails(String id) async {
  final url = Uri.parse(urlCrowdFundingDetails);
  Map<String, dynamic> parameters = {
    'id': id,
  };
  try {
    Uri uriWithParams = Uri.https(url.authority, url.path, parameters);
    log('uri withparams $uriWithParams');

    final response = await http.get(uriWithParams);
    log('response : ${response.body}');
    final data = json.decode(response.body);
    log('data $data');
    final CrowdfundingOutput crowdfundingOutput =
        CrowdfundingOutput.fromJson(data);
    log(crowdfundingOutput.toString());
    return crowdfundingOutput;
  } catch (e) {
    throw Exception(
      'Failed to connect to the server to get getCrowdfundingDetails',
    );
  }
}
