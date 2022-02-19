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

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

//Networking Section Here
//TODO: Add your own Cryptocurrency API
const String apiDomain = '';
String apiDomainPath =
    ''; //ApiDomainPath changes based on the currency and cryptocurrency selected
const Map<String, dynamic> apiArguments = {};
const String apiKey = '';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      apiDomainPath =
          '/$crypto/$selectedCurrency'; //This depends on the structure provided by the api. This just illustrates why we used a loop
      Uri uri = Uri.http(apiDomain, apiDomainPath, apiArguments);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        //data retrieved from your API response (Probably Json)
        //TODO: Decode the data sent from your own api depending on the response acquired
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
