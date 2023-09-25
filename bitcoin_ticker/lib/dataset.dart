import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static const apiKey = 'DAEFDB5E-AE96-4F8E-9534-2765D838B6C8';

  Future<Map<String, double>> getExchangeRates(String currency) async {
    Map<String, double> exchangeRates = {};

    for (String crypto in cryptoList) {
      final response = await http.get(
        Uri.parse('https://rest.coinapi.io/v1/exchangerate/$crypto/$currency'),
        headers: {'X-CoinAPI-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double rate = data['rate'];
        exchangeRates[crypto] = rate;
      } else {
        throw Exception('No se pudieron obtener los datos');
      }
    }

    return exchangeRates;
  }
}