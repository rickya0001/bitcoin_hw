import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/bitcoin_API.dart';

class MockClient extends Mock implements http.Client{}

void main() {
  
   test('returns a String if the http call completes successfully'() async{


        final client = MockClient();
        final fakeCoinAPIData = 
        {
            {"time":{
              "updated":"Mar 27, 2021 23:11:00 UTC","updatedISO":"2021-03-27T23:11:00+00:00","updateduk":"Mar 27, 2021 at 23:11 GMT"
              },
              "disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
              "bpi":{
                "USD":
                {"code":"USD","rate":"56,290.2083","description":"United States Dollar","rate_float":56290.2083}}}
        }
        when(client.get('https://api.coindesk.com/v1/bpi/currentprice/usd.json')).thenAnswer((_) async => http.Response(fakeCoinAPIData,200));

        String price = await BitcoinAPI.fetchBTC(client);

        expect(price, isA<String());
        

        expect(price,56290.2083);

    });

    test('throws and exceptionif the http call completes with an error', () {


        final client = MockClient();
        when(client.get('https://api.coindesk.com/v1/bpi/currentprice/usd.json')).thenAnswer((_) async => http.Response('Not Found',404));

        expect(BitcoinAPI.fetchBTC(client),throwsException);

    });
  test('2 plus 2 is 4', () {
    int result = 2 + 2;
    expect(result, 4);
  });
  group("USDtoBTC", () {
    test('convert 1 USD to BTC', () {
      var btcvalue = CalculatorTools.usdToBtcCalculator(1);
      expect(btcvalue, 0.000018);
    });
    test('throw arguement error on negative', () {
      expect(() => CalculatorTools.usdToBtcCalculator(-1), throwsArgumentError);
    });
    test('throw arguement error on zero', () {
      expect(() => CalculatorTools.usdToBtcCalculator(0), throwsArgumentError);
    });
  });
  group("BTCtoUSD", () {
    test('convert 1 BTC to USD', () {
      var btcvalue = CalculatorTools.btcToUsdCalculator(1);
      expect(btcvalue, 57232.80);
    });
    test('throw arguement error on negative', () {
      expect(() => CalculatorTools.btcToUsdCalculator(-1), throwsArgumentError);
    });
    test('throw arguement error on zero', () {
      expect(() => CalculatorTools.btcToUsdCalculator(0), throwsArgumentError);
    });
  });
}
