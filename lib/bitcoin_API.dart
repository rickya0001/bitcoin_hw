import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinAPI {
  static Future<String> fetchBTC(http.Client client) async {
    final response = await client
        .get(' https://api.coindesk.com/v1/bpi/currentprice/usd.json');

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception('Failed to get value');
    }
  }
}
