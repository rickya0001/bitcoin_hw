import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart':
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/bitcoin_API.dart';

class MockClient extends Mock implements http.Client{}

main(){

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
        when(client.get(Api link)).thenAnswer((_) async => http.Response(fakeCoinAPIData,200));

        String price = await BitcoinAPI.fetchBTC(client);

        expect(price, isA<string>());

        expect(price,56290.2083);

    });

    test('throws and exceptionif the http call completes with an error', () {


        final client = MockClient();
        when(client.get('https://api.coindesk.com/v1/bpi/currentprice/usd.json')).thenAnswer((_) async => http.Response('Not Found',404));

        expect(BitcoinAPI.fetchBTC(client),throwsException);

    });

}
}