// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/ExchangeRate.dart';
import 'package:myapp/MoneyBox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.deepOrange),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ExchangeRate _dataFromAPI;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future<ExchangeRate> getExchangeRate() async {
    var url = "https://open.er-api.com/v6/latest/THB";
    var response = await http.get(Uri.parse(url));
    _dataFromAPI = exchangeRateFromJson(response.body);
    return _dataFromAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Money Exchenge")),
        ),
        body: FutureBuilder(
          future: getExchangeRate(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;
              double number = 9000;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MoneyBox("สกุลเงินร่วมต้น THB", number, Colors.blue, 150),
                    MoneyBox(
                        "USD", number * result.rates["USD"], Colors.green, 100),
                    MoneyBox(
                        "JPY", number * result.rates["JPY"], Colors.pink, 100),
                    MoneyBox(
                        "EUR", number * result.rates["EUR"], Colors.orange, 100)
                  ],
                ),
              );
            }
            return LinearProgressIndicator();
          },
        ));
  }
}
