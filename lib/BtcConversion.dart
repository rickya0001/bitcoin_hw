import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/calculator.dart';
import 'package:bitcoin_calculator/bitcoin_API.dart';
import 'package:config/globals.dart';

class BtcConversion extends StatefulWidget {
  @override
  _BtcConversionState createState() => _BtcConversionState();
}

//BtcConversion
class _BtcConversionState extends State<BtcConversion> {
  final conversionTextController = TextEditingController();

  bool convertButton = false;
  bool keyboardError = false;
  bool finalValue = false;
  double bcValue = 0.0;
  double usdValue = 0.0;
  Future<String> futureBTC;

  @override
  void initState() {
    super.initState();
    futureBTC = BitcoinAPI.fetchBTC(httpClient());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          key: Key('back-button'),
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.chevron_left,
            color: Color(0xFF009195),
          ),
        ),
        title: Text("BTC to USD",
            key: Key('btcToUsdTitle'),
            style: TextStyle(
              color: Color(0xFF009195),
            )),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(finalValue ? "Input: $bcValue\nResults: $usdValue" : '',
                style: TextStyle(color: Colors.green, fontSize: 16),
                key: Key('results-text')),
            TextField(
                keyboardType: TextInputType.number,
                controller: conversionTextController,
                key: Key('conversion-textfield'),
                onChanged: (text) {
                  setState(() {
                    if (double.parse(text) > 0) {
                      convertButton = true;
                      keyboardError = false;
                    } else {
                      convertButton = false;
                      keyboardError = true;
                    }
                  });
                }),
            Text(!keyboardError ? '' : "Invalid Input",
                style: TextStyle(color: Colors.red), key: Key('error-text')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: Color(0xFF009195),
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Norwester',
                      letterSpacing: 1.2)),
              key: Key('conversion-button'),
              onPressed: convertButton
                  ? () {
                      setState(() {
                        // Do math stuff
                        if (convertButton) {
                          bcValue = double.parse(conversionTextController.text);
                          usdValue =
                              CalculatorTools.btcToUsdCalculator(bcValue);
                          finalValue = true;
                        } else {
                          finalValue = false;
                        }
                      });
                    }
                  : null,
              child: Text('Convert'),
            ),
            FutureBuilder<String>(
              future: futureBTC,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String btc = snapshot.data;
                  return Text(btc);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            )
          ])),
    );
  }
}
