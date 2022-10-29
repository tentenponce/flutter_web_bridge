import 'dart:html';
import 'dart:js' as js; //import dart:js library

import 'package:flutter/material.dart';
import 'package:flutter_web_bridge/flutter_web_bridge.dart';
import 'package:flutter_web_bridge/models/payment_param.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mini App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Mini App Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _txnId = '6c8f52ef-48fe-4aaa-8ad3-ea94130e6d33';
  String _name = '{name}';
  double _amount = 0;

  @override
  void initState() {
    super.initState();

    FlutterWebBridge.init(window, onPaymentEvent: ((paymentResult) {
      setState(() {
        _txnId = paymentResult.transactionId;
      });
    }), onUserEvent: (name) {
      setState(() {
        _name = name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello $_name from flutter mini app'),
            Text('transaction ID: $_txnId', textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextFormField(
                decoration: const InputDecoration(label: Text('Amount')),
                onChanged: (value) {
                  setState(() {
                    _amount = double.tryParse(value) ?? 0;
                  });
                }),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _txnId = ''; // reset message
                });

                FlutterWebBridge.pay(PaymentParam(
                  channel: 'sample_bank_code',
                  amount: _amount,
                ));
              },
              child: const Text('Submit payment'),
            )
          ],
        ),
      ),
    );
  }
}
