library flutter_web_bridge;

import 'dart:convert';
import 'dart:html';
import 'dart:js' as js; //import dart:js library

import 'package:flutter_web_bridge/models/payment_param.dart';
import 'package:flutter_web_bridge/models/payment_result.dart';

/// sample custom library for connecting flutter web app
/// to a mobile app
class FlutterWebBridge {
  static const String _eventUser = 'eventUser';
  static const String _eventPayment = 'eventPayment';
  static const String _jsChannelPay = 'channelPay';

  /// initialize event to be handled by the mini app
  static init(
    Window window, {
    required Function(PaymentResult paymentResult) onPaymentEvent,
    required Function(String name) onUserEvent,
  }) {
    window.addEventListener(_eventPayment, (event) {
      CustomEvent customEvent = event as CustomEvent;

      PaymentResult paymentResult =
          PaymentResult.fromJson(json.decode(customEvent.detail));
      onPaymentEvent(paymentResult);
    });

    window.addEventListener(_eventUser, (event) {
      CustomEvent customEvent = event as CustomEvent;

      String name = customEvent.detail;
      onUserEvent(name);
    });
  }

  /// trigger a function on the super app
  static pay(PaymentParam param) {
    var state = js.JsObject.fromBrowserObject(js.context[_jsChannelPay]);
    state.callMethod('postMessage', [json.encode(param)]);
  }
}
