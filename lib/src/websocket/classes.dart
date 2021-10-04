import '../common/classes.dart';
import '../common/enums.dart';

class WsAggTrade extends AggTrade {
  final String eventType;
  final int eventTime;
  final String symbol;

  WsAggTrade.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        super.fromMap(m);
}

class WsTrade {
  String eventType;
  int eventTime;
  String symbol;
  int tradeId;
  double price;
  double qty;
  int buyOrderId;
  int sellOrderId;
  int timestamp;
  bool isBuyerMaker;

  WsTrade.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        tradeId = m['t'],
        price = double.parse(m['p']),
        qty = double.parse(m['q']),
        buyOrderId = m['b'],
        sellOrderId = m['a'],
        timestamp = m['T'],
        isBuyerMaker = m['m'];
}

class WsKline {
  final int startTime;
  final int closeTime;
  final String symbol;
  final Interval? interval;
  final int firstTradeId;
  final int lastTradeId;
  final double open;
  final double high;
  final double close;
  final double low;
  final double baseAssetVolume;
  final int tradeCount;
  final bool isClosed;
  final double quoteAssetVolume;
  final double takerBuyBaseAssetVolume;
  final double takerBuyQuoteAssetVolume;
  WsKline.fromMap(Map m)
      : startTime = m['t'],
        closeTime = m['T'],
        symbol = m['s'],
        interval = (m['i'] as String).toIntervalEnum(),
        firstTradeId = m['f'],
        lastTradeId = m['L'],
        open = double.parse(m['o']),
        high = double.parse(m['h']),
        close = double.parse(m['c']),
        low = double.parse(m['l']),
        baseAssetVolume = double.parse(m['v']),
        tradeCount = m['n'],
        isClosed = m['x'],
        quoteAssetVolume = double.parse(m['q']),
        takerBuyBaseAssetVolume = double.parse(m['V']),
        takerBuyQuoteAssetVolume = double.parse(m['Q']);
}

class WsKlineEvent {
  final String eventType;
  final int eventTime;
  final String symbol;
  final WsKline kline;

  WsKlineEvent.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        kline = WsKline.fromMap(m["k"]);
}

class WsMiniTicker {
  String eventType;
  int eventTime;
  String symbol;
  double close;
  double open;
  double high;
  double low;
  double volume;
  double quoteVolume;

  WsMiniTicker.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        close = double.parse(m['c']),
        open = double.parse(m['o']),
        high = double.parse(m['h']),
        low = double.parse(m['l']),
        volume = double.parse(m['v']),
        quoteVolume = double.parse(m['q']);
}

class WsTicker {
  String eventType;
  int eventTime;
  String symbol;
  double priceChange;
  double prichePercentChange;
  double weightedAvgPrice;
  double firstTradePrice;
  double lastPrice;
  double lastQty;
  double bestBid;
  double bestBidQty;
  double bestAsk;
  double bestAskQty;
  double open;
  double high;
  double low;
  double volume;
  double quoteVolume;
  int statsOpenTime;
  int statsCloseTime;
  int firstTradeId;
  int lastTradeId;
  int numberOfTrades;

  WsTicker.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        priceChange = double.parse(m['p']),
        prichePercentChange = double.parse(m['P']),
        weightedAvgPrice = double.parse(m['w']),
        firstTradePrice = double.parse(m['x']),
        lastPrice = double.parse(m['c']),
        lastQty = double.parse(m['Q']),
        bestBid = double.parse(m['b']),
        bestBidQty = double.parse(m['B']),
        bestAsk = double.parse(m['a']),
        bestAskQty = double.parse(m['A']),
        open = double.parse(m['o']),
        high = double.parse(m['h']),
        low = double.parse(m['l']),
        volume = double.parse(m['v']),
        quoteVolume = double.parse(m['q']),
        statsOpenTime = m['O'],
        statsCloseTime = m['C'],
        firstTradeId = m['F'],
        lastTradeId = m['L'],
        numberOfTrades = m['n'];
}

class WsOrderBook {
  int updateId;
  String symbol;
  double bestBid;
  double bestBidQty;
  double bestAsk;
  double bestAskQty;

  WsOrderBook.fromMap(Map m)
      : updateId = m['u'],
        symbol = m['s'],
        bestBid = double.parse(m['b']),
        bestBidQty = double.parse(m['B']),
        bestAsk = double.parse(m['a']),
        bestAskQty = double.parse(m['A']);
}

class WsPartialOrderBook {
  int lastUpdateId;
  List<DepthOrder> bids;
  List<DepthOrder> asks;

  WsPartialOrderBook.fromMap(Map m)
      : lastUpdateId = m['lastUpdateId'],
        bids = (m['bids'] as List<dynamic>)
            .map((e) => DepthOrder.fromList(e))
            .toList(),
        asks = (m['asks'] as List<dynamic>)
            .map((e) => DepthOrder.fromList(e))
            .toList();
}

class WsDiffOrderBook {
  String eventType;
  int eventTime;
  String symbol;
  int firstUpdateId;
  int lastUpdateId;
  List<DepthOrder> bids;
  List<DepthOrder> asks;

  WsDiffOrderBook.fromMap(Map m)
      : eventType = m['e'],
        eventTime = m['E'],
        symbol = m['s'],
        firstUpdateId = m['U'],
        lastUpdateId = m['u'],
        bids = (m['b'] as List<dynamic>)
            .map((e) => DepthOrder.fromList(e))
            .toList(),
        asks = (m['a'] as List<dynamic>)
            .map((e) => DepthOrder.fromList(e))
            .toList();
}
