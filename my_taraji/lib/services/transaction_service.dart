import 'package:http/http.dart' as http;
import 'package:my_taraji/services/enums/financial_transaction_type.dart';
import 'package:my_taraji/views/challenge/import.dart';
import 'package:my_taraji/views/fanpay/models/account_card.dart';
import 'package:my_taraji/views/fanpay/models/transaction_response.dart';
import 'package:my_taraji/views/fanpay/models/transaction_model.dart';

class TransactionService {
  late String baseUrl = "https://devmytarajiapi.azurewebsites.net";

  TransactionService();

  Future<TransactionSettings> getTransactionSettings(
      TransactionType type) async {
    const path = "api/v1/settings-mobile";
    final url = Uri.parse('$baseUrl/$path?settingsType=${type.index}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        return TransactionSettings.fromJson(jsonData);
      } else {
        throw Exception('Failed API call: ${response.reasonPhrase}');
      }
    } catch (e) {
      if (e.toString().contains('400')) {
        throw Exception('Failed to load Don data');
      } else {
        throw Exception('Failed to connect to the server for Don data $e');
      }
    }
  }

  Future<double> getCoinsConvertor(String amount) async {
    const path = "api/v1/settings-mobile/coins-convertor";
    final url = Uri.parse('$baseUrl/$path?amount=$amount');

    try {
      final response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return double.parse(jsonData['data'].toString());
    } catch (e) {
      throw Exception('Failed API call: $e');
    }
  }

  Future<APIResponseModel<TransactionResponse>> createTransaction(
      TransactionModel don) async {
    const path = "api/v1/donation";
    final url = Uri.parse('$baseUrl/$path');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(don.toJson()),
    );

    debugPrint(jsonEncode(don.toJson()).toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return APIResponseModel<TransactionResponse>.fromJson(
        jsonData,
        (data) => TransactionResponse.fromJson(data),
      );
    } else {
      throw Exception('Failed to create donation - ${response.reasonPhrase}');
    }
  }

  Future<APIResponseModel<AccountCard>> getWalletDetails() async {
    const path = "api/v1/wallet/wallet-details";
    final url = Uri.parse('$baseUrl/$path');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return APIResponseModel<AccountCard>.fromJson(
        jsonData,
        (data) => AccountCard.fromJson(data),
      );
    } else {
      throw Exception(
          'Failed to get wallet details - ${response.reasonPhrase}');
    }
  }

  Future<APIResponseModel<List<TransactionModel>>> getTransactionHistories({
    String order = "",
    int page = 0,
    int size = 10,
    String sort = "",
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const path = "api/v1/financial-transaction/histories";
    final url = Uri.parse('$baseUrl/$path');

    User user = User.fromJson(json.decode(prefs.getString('user')!));

    Map<String, String> headers = {
      'Authorization': 'Bearer ${user.currentToken}',
      'Content-Type': 'application/json',
    };

    debugPrint(user.currentToken.toString());

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "order": order,
        "page": page,
        "size": size,
        "sort": sort,
      }),
    );

    debugPrint(response.headers.toString());
    debugPrint(response.body.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.reasonPhrase.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return APIResponseModel<List<TransactionModel>>.fromJson(
        jsonData,
        (data) => (data as List)
            .map((e) => TransactionModel.fromJson(e))
            .toList(growable: false),
      );
    } else {
      throw Exception(
          'Failed to get transaction histories - ${response.reasonPhrase}');
    }
  }
}
