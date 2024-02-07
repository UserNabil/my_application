import 'dart:developer';

import 'package:my_taraji/core/api/urls.dart';
import 'package:my_taraji/views/fanpay/models/recharge/payement_output.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RechareService {
  Future<PaymentOutput> getPaymentInfo(String amount) async {
    final url = Uri.parse(urlCbRecharge);
    Map<String, dynamic> parameters = {
      'Amount': amount,
      'RechargeType': '0',
    };

    Uri uriWithParams = Uri.https(url.authority, url.path, parameters);
    log('uri withparams $uriWithParams');

    final response = await http.post(uriWithParams);
    log('response : ${response.body}');
    final data = json.decode(response.body);
    log('${PaymentOutput.fromJson(data).data}');
    return PaymentOutput.fromJson(data);
  }
}
