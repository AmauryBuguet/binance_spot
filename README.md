# binance_spot

This is an unofficial Dart wrapper for Binance SPOT API.  
For now it includes market, trade, subaccount, and fiat endpoints, as well as support for market and user data streams.  
Feel free to submit pull requests I will be glad to accept them if they match the coding style.  
This library has been partially auto-generated (using a custom tool I made), so do not hesitate to submit an issue if you find one.  

## Currently supported :
* Market Data Endpoints
* Sub-Account Endpoints
* Wallet Endpoints
* Spot Account / Trade Endpoints
* Fiat Endpoints
* Websocket market streams
* User data streams

## Useful links
* [Binance API docs](https://binance-docs.github.io/apidocs/spot/en/)

## Getting Started
### Install
```yaml
dependencies:
  binance_spot: ^0.0.1
```

or use
```
flutter pub add binance_spot
```

### Usage
```dart
import 'dart:async';

import 'package:binance_spot/binance_spot.dart';
import 'package:flutter/material.dart' hide Interval;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BinanceSpot binanceSpot = BinanceSpot(
    key: "<apiKey>",
    secret: "<apiSecret>",
  );
  double lastClosePrice = 0;
  String tradablePairs = "";
  String lastEventData = "";
  late StreamSubscription<dynamic> klineStreamSub;
  late StreamSubscription<dynamic> userdataStreamSub;
  @override
  void initState() {
    startKlineStream();
    startUserdataStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binance API tester"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Current BTC price : $lastClosePrice"),
            Text("Last userdataStream event : $lastEventData"),
            TextButton(
              onPressed: getTradablePairs,
              child: const Text("GET PAIRS"),
            ),
            Expanded(
              flex: 1,
              child: SelectableText(
                tradablePairs,
                maxLines: 200,
                minLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startKlineStream() {
    var stream = binanceSpot.klineStream(
      symbol: "BTCUSDT",
      interval: Interval.INTERVAL_5m,
    );
    klineStreamSub = stream.listen(handleNewKline);
  }

  void handleNewKline(WsKlineEvent event) {
    setState(() {
      lastClosePrice = event.kline.close;
    });
  }

  void startUserdataStream() async {
    var response = await binanceSpot.createListenKey();
    if (response.isRight) {
      var stream = binanceSpot.userDataStream(listenKey: response.right);
      userdataStreamSub = stream.listen(handleUserdataEvent);
    } else {
      lastEventData = response.left;
    }
  }

  void handleUserdataEvent(dynamic event) {
    if (event is WsAccountUpdate) {
      lastEventData = "Account update event : ${event.balances.length} balances updated";
    } else if (event is WsBalanceUpdate) {
      lastEventData = "Balance update event : ${event.asset} balance updated";
    } else if (event is WsExecutionReport) {
      lastEventData = "Execution report event : status is ${event.orderStatus.toStr()}";
    } else if (event is WsListOrderStatus) {
      lastEventData = "ListOrder update event : status is ${event.listOrderStatus}";
    } else {
      lastEventData = "Unknown event type : ${event.toString()}";
    }
  }

  void getTradablePairs() async {
    var response = await binanceSpot.exchangeInfo();
    if (response.isLeft) {
      tradablePairs = response.left;
    } else {
      var listSymbol = response.right.symbols.map((e) => e.symbol).toList();
      tradablePairs = "";
      for (var s in listSymbol) {
        tradablePairs += "$s ";
      }
    }
  }
}

```
