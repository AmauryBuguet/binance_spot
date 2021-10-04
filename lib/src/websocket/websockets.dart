import 'classes.dart';

import '../binance_spot_api.dart';
import '../common/classes.dart';
import '../common/enums.dart';

extension Websockets on BinanceSpot {
  /// The Aggregate Trade Streams push trade information that is aggregated for a single taker order.
  Stream<WsAggTrade> aggregatedTradeStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@aggTrade');
    return channel.stream.map<Map>(toMap).map<WsAggTrade>((e) => WsAggTrade.fromMap(e));
  }

  /// The Trade Streams push raw trade information, each trade has a unique buyer and seller.
  Stream<WsTrade> tradeStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@trade');
    return channel.stream.map<Map>(toMap).map<WsTrade>((e) => WsTrade.fromMap(e));
  }

  /// The Kline/Candlestick Stream push updates to the current klines/candlestick every second.
  Stream<WsKlineEvent> klineStream({required String symbol, required Interval interval}) {
    final channel = subscribe('${symbol.toLowerCase()}@kline_${interval.toStr()}');
    return channel.stream.map<Map>(toMap).map<WsKlineEvent>((e) => WsKlineEvent.fromMap(e));
  }

  /// 24hr rolling window mini-ticker statistics.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window for the previous 24hrs.
  Stream<WsMiniTicker> miniTickerStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@miniTicker');
    return channel.stream.map<Map>(toMap).map<WsMiniTicker>((e) => WsMiniTicker.fromMap(e));
  }

  /// 24hr rolling window mini-ticker statistics for all symbols that changed in an array.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window for the previous 24hrs.
  /// Note that only tickers that have changed will be present in the array.
  Stream<List<WsMiniTicker>> allMiniTickerStream() {
    final channel = subscribe('!miniTicker@arr');
    return channel.stream.map<List>(toList).map<List<WsMiniTicker>>((e) => e.map((a) => WsMiniTicker.fromMap(a)).toList());
  }

  /// 24hr rolling window ticker statistics for a single symbol.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window for the previous 24hrs.
  Stream<WsTicker> tickerStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@ticker');
    return channel.stream.map<Map>(toMap).map<WsTicker>((e) => WsTicker.fromMap(e));
  }

  /// 24hr rolling window ticker statistics for all symbols that changed in an array.
  ///
  /// These are NOT the statistics of the UTC day, but a 24hr rolling window for the previous 24hrs.
  /// Note that only tickers that have changed will be present in the array.
  Stream<List<WsTicker>> allTickerStream() {
    final channel = subscribe('!ticker@arr');
    return channel.stream.map<List>(toList).map<List<WsTicker>>((e) => e.map((a) => WsTicker.fromMap(a)).toList());
  }

  /// Pushes any update to the best bid or ask's price or quantity in real-time for a specified symbol.
  Stream<WsOrderBook> orderbookStream({required String symbol}) {
    final channel = subscribe('${symbol.toLowerCase()}@bookTicker');
    return channel.stream.map<Map>(toMap).map<WsOrderBook>((e) => WsOrderBook.fromMap(e));
  }

  /// Pushes any update to the best bid or ask's price or quantity in real-time for a specified symbol.
  Stream<WsOrderBook> allOrderbookStream() {
    final channel = subscribe('!bookTicker');
    return channel.stream.map<Map>(toMap).map<WsOrderBook>((e) => WsOrderBook.fromMap(e));
  }

  /// Top bids and asks, Valid are 5, 10, or 20.
  Stream<WsPartialOrderBook> partialOrderbookStream({
    required String symbol,
    required int nbLevel,
    bool is100ms = false,
  }) {
    final channel = subscribe('${symbol.toLowerCase()}@depth$nbLevel' + (is100ms ? "@100ms" : ""));
    return channel.stream.map<Map>(toMap).map<WsPartialOrderBook>((e) => WsPartialOrderBook.fromMap(e));
  }

  /// Order book price and quantity depth updates used to locally manage an order book.
  Stream<WsDiffOrderBook> diffOrderbookStream({
    required String symbol,
    bool is100ms = false,
  }) {
    final channel = subscribe('${symbol.toLowerCase()}@depth' + (is100ms ? "@100ms" : ""));
    return channel.stream.map<Map>(toMap).map<WsDiffOrderBook>((e) => WsDiffOrderBook.fromMap(e));
  }

  /// Subscribe to userdata stream
  ///
  /// data pushed can be WsAccountUpdate / WsBalanceUpdate / WsExecutionReport / WsListOrderStatus or Map if unknown
  Stream<dynamic> userDataStream({
    required String listenKey,
  }) {
    final channel = subscribe(listenKey);
    return channel.stream.map<Map>(toMap).map<dynamic>((e) {
      if (e["e"] == "outboundAccountPosition") {
        return WsAccountUpdate.fromMap(e);
      } else if (e["e"] == "balanceUpdate") {
        return WsBalanceUpdate.fromMap(e);
      } else if (e["e"] == "executionReport") {
        return WsExecutionReport.fromMap(e);
      } else if (e["e"] == "listStatus") {
        return WsListOrderStatus.fromMap(e);
      } else {
        return e;
      }
    });
  }
}
