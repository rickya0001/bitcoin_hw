// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  group('Happy paths', () {
    //from choice screen tap USD to BTC
    //input a valid USD amount 1
    //if valid press convert
    //see BTC conversion
    test("should be on conversion choice screen for USD to BTC", () async {
      // Look for variables on conversion screen
      final usdToBTCText = find.byValueKey('usdToBtcText');
      expect(await driver.getText(usdToBTCText), 'USD to BTC');
      final usdToBTC = find.byValueKey('usdToBtcButton');
      // expect to find the button
      await driver.tap(usdToBTC);
      await Future.delayed(const Duration(seconds: 2), () {});
      // Variables for calculation page
      // Find USD to BTC title in app bar
      final usdToBtcText = find.byValueKey('usdToBtcTitle');
      final usdToBtcTextfield = find.byValueKey('conversion-textfield');
      final conversionButton = find.byValueKey('conversion-button');
      final resultsText = find.byValueKey('results-text');
      final backButton = find.byValueKey('back-button');
      // Expect to see USD to BTC on this page
      expect(await driver.getText(usdToBtcText), 'USD to BTC');
      await Future.delayed(const Duration(seconds: 2), () {});

      // Now enter 1 into the text field and tap convert
      await driver.tap(usdToBtcTextfield);
      await driver.enterText("1");
      await driver.waitFor(find.text("1"));
      await driver.tap(conversionButton);
      // Expect to see results
      expect(
          await driver.getText(resultsText), 'Input: 1.0\nResults: 0.000018');
      await Future.delayed(const Duration(seconds: 2), () {});
      // Hit the back button
      await driver.tap(backButton);
    });

    //from choice screen tap BTC to USD
    //input a valid BTC amount 1
    //if valid press convert
    //see USD conversion
    test("should be on conversion choice screen for BTC to USD", () async {
      // Look for variables on conversion screen
      final btcToUSDText = find.byValueKey('btcToUsdText');
      expect(await driver.getText(btcToUSDText), 'BTC to USD');
      final usdToBTC = find.byValueKey('btcToUsdButton');

      // expect to find the button
      await driver.tap(usdToBTC);
      await Future.delayed(const Duration(seconds: 2), () {});

      // Variables for calculation page
      // Find USD to BTC title in app bar
      final btcToUsdText = find.byValueKey('btcToUsdTitle');
      final btcToUsdTextfield = find.byValueKey('conversion-textfield');
      final conversionButton = find.byValueKey('conversion-button');
      final resultsText = find.byValueKey('results-text');
      final backButton = find.byValueKey('back-button');

      // Expect to see USD to BTC on this page
      expect(await driver.getText(btcToUsdText), 'BTC to USD');
      await Future.delayed(const Duration(seconds: 2), () {});

      // Now enter 1 into the text field and tap convert
      await driver.tap(btcToUsdTextfield);
      await driver.enterText("1");
      await driver.waitFor(find.text("1"));

      await driver.tap(conversionButton);

      // Expect to see results
      expect(await driver.getText(resultsText), 'Input: 1.0\nResults: 57232.8');
      await Future.delayed(const Duration(seconds: 2), () {});

      // Hit the back button
      await driver.tap(backButton);
    });
  });

  group('Sad Paths', () {
//Given I am on the main page
//when I tap on USD to BTC button
// enter invaild value
//I should get arguement error
    test('I should see error message when puttin invaild input USD to BTC',
        () async {
      // Look for variables on conversion screen
      final usdToBTCText = find.byValueKey('usdToBtcText');
      expect(await driver.getText(usdToBTCText), 'USD to BTC');
      final usdToBTC = find.byValueKey('usdToBtcButton');
      final usdToBtcText = find.byValueKey('usdToBtcTitle');
      final usdToBtcTextfield = find.byValueKey('conversion-textfield');
      final errorText = find.byValueKey('error-text');
      final backButton = find.byValueKey('back-button');

// expect to find the button
      await driver.tap(usdToBTC);
      await Future.delayed(const Duration(seconds: 2), () {});
      // Expect to see USD to BTC on this page
      expect(await driver.getText(usdToBtcText), 'USD to BTC');
      await Future.delayed(const Duration(seconds: 2), () {});
      //Enter the -1
      await driver.tap(usdToBtcTextfield);
      await driver.enterText('-1');
      await driver.waitFor(find.text('-1'));

//expect to see error text
      expect(await driver.getText(errorText), 'Invalid Input');
      await Future.delayed(const Duration(seconds: 2), () {});

      // Hit the back button
      await driver.tap(backButton);
    });

//Given I am on the main page
//when I tap on BTC to USD button
// enter invaild value
//I should get arguement error
    test('I should see error message when puttin invaild input BTC to USD',
        () async {
      // Look for variables on conversion screen
      final btcToUSDText = find.byValueKey('btcToUsdText');
      expect(await driver.getText(btcToUSDText), 'BTC to USD');
      // Variables for calculation page
      final usdToBTC = find.byValueKey('btcToUsdButton');
      final btcToUsdText = find.byValueKey('btcToUsdTitle');
      final btcToUsdTextfield = find.byValueKey('conversion-textfield');
      final errorText = find.byValueKey('error-text');
      final backButton = find.byValueKey('back-button');

// expect to find the button
      await driver.tap(usdToBTC);
      await Future.delayed(const Duration(seconds: 2), () {});

      // Expect to see USD to BTC on this page
      expect(await driver.getText(btcToUsdText), 'BTC to USD');
      await Future.delayed(const Duration(seconds: 2), () {});
      //Enter the -1
      await driver.tap(btcToUsdTextfield);
      await driver.enterText('-1');
      await driver.waitFor(find.text('-1'));

//expect to see error text
      expect(await driver.getText(errorText), 'Invalid Input');
      await Future.delayed(const Duration(seconds: 2), () {});

      // Hit the back button
      await driver.tap(backButton);
    });
  });
}
