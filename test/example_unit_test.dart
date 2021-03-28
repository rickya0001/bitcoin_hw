import 'package:bitcoin_calculator/calculator.dart';
import 'package:test/test.dart';

void main() {
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
