import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/calculator.dart';

class UsdConversion extends StatefulWidget {
  @override
  _UsdConversionState createState() => _UsdConversionState();
}

class _UsdConversionState extends State<UsdConversion> {
  final conversionTextController = TextEditingController();

  bool convertButton = false;
  bool keyboardError = false;
  bool finalValue = false;
  double usdValue = 0.0;
  double bcValue = 0.0;

  @override
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
        title: Text("USD to BTC",
            key: Key('usdToBtcTitle'),
            style: TextStyle(
              color: Color(0xFF009195),
            )),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(finalValue ? "Input: $usdValue\nResults: $bcValue" : '',
                style: TextStyle(color: Colors.green, fontSize: 16),
                key: Key('results-text')),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: conversionTextController,
                key: Key('conversion-textfield'),
                onChanged: (text) {
                  setState(() {
                    if (double.parse(text) > 0 &&
                        conversionTextController.text.isNotEmpty) {
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
                        if (convertButton) {
                          usdValue =
                              double.parse(conversionTextController.text);
                          bcValue =
                              CalculatorTools.usdToBtcCalculator(usdValue);
                          finalValue = true;
                        } else {
                          finalValue = false;
                        }
                      });
                    }
                  : null,
              child: Text('Convert'),
            ),
          ])),
    );
  }
}
