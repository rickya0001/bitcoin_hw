import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/UsdConversion.dart';
import 'package:bitcoin_calculator/BtcConversion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversion App',
      key: Key('home-page-text'),
      home: MyHomePage(title: 'Money Converter Home Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF009195),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title,
            style: TextStyle(
              color: Color(0xFF009195),
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Norwester',
                      letterSpacing: 1.2)),
              key: Key('usdToBtcButton'),
              child: Text('USD to BTC',
                  key: Key('usdToBtcText'),
                  style: TextStyle(
                    color: Color(0xFF009195),
                  )),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsdConversion()),
                );
              },
            ),
            Padding(padding: EdgeInsets.all(3.0)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Norwester',
                      letterSpacing: 1.2)),
              key: Key('btcToUsdButton'),
              child: Text('BTC to USD',
                  key: Key('btcToUsdText'),
                  style: TextStyle(color: Color(0xFF009195))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BtcConversion()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
