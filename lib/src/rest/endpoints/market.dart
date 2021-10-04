import 'package:either_dart/either.dart';

import '../classes.dart';
import '../enums.dart';

import '../../binance_spot_api.dart';
import '../../common/enums.dart';
import '../../common/classes.dart';

/// Market Data Endpoints for Binance Spot API
extension MarketEndpoints on BinanceSpot {
  /// Test connectivity to the Rest API.
  Future<Either<String, bool>> testPing() => sendRequest(
        path: '$prefix/ping',
        type: RequestType.GET,
      ).then((r) => r.isRight ? const Right(true) : Left(r.left));

  /// Test connectivity to the Rest API and get the current server time.
  Future<Either<String, int>> serverTime() => sendRequest(
        path: '$prefix/time',
        type: RequestType.GET,
      ).then((r) => r.isRight ? Right(r.right['serverTime']) : Left(r.left));

  /// Current exchange trading rules and symbol information
  ///
  /// symbols param string must be this format '\["BTCUSDT","BNBBTC"\]'
  Future<Either<String, ExchangeInfo>> exchangeInfo({
    String? symbol,
    String? symbols,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    if (symbols != null) params['symbols'] = symbols;
    return sendRequest(
      path: '$prefix/exchangeInfo',
      type: RequestType.GET,
      params: params,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(ExchangeInfo.fromMap(r.right)));
  }

  /// Order book adjusted based on the limits
  Future<Either<String, OrderBook>> orderBook({
    required String symbol,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'api/v3/depth',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : Right(OrderBook.fromMap(r.right)));
  }

  /// Get recent market trades
  Future<Either<String, List<Trade>>> recentTradesList({
    required String symbol,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'api/v3/trades',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Trade>.from(r.right.map((e) => Trade.fromMap(e)))));
  }

  /// Get older market historical trades.
  Future<Either<String, List<Trade>>> oldTradeLookup({
    required String symbol,
    int? limit,
    int? fromId,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (limit != null) params['limit'] = limit.toString();
    if (fromId != null) params['fromId'] = fromId.toString();
    return sendRequest(
      path: 'api/v3/historicalTrades',
      type: RequestType.GET,
      keyRequired: true,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Trade>.from(r.right.map((e) => Trade.fromMap(e)))));
  }

  /// Get compressed, aggregate market trades.
  /// Market trades that fill at the time, from the same order, with the same price will have the quantity aggregated.
  Future<Either<String, List<AggTrade>>> aggregateTradesList({
    required String symbol,
    int? fromId,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    if (fromId != null) params['fromId'] = fromId.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'api/v3/aggTrades',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<AggTrade>.from(r.right.map((e) => AggTrade.fromMap(e)))));
  }

  /// Kline/candlestick bars for a symbol. Klines are uniquely identified by their open time.
  Future<Either<String, List<Kline>>> candlestickData({
    required String symbol,
    required Interval interval,
    int? startTime,
    int? endTime,
    int? limit,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
      'interval': interval.toStr(),
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    return sendRequest(
      path: 'api/v3/klines',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Kline>.from(r.right.map((e) => Kline.fromMap(e)))));
  }

  /// Current average price for a symbol.
  Future<Either<String, AveragePrice>> currentAveragePrice({
    required String symbol,
  }) {
    Map<String, String> params = {
      'symbol': symbol,
    };
    return sendRequest(
      path: 'api/v3/avgPrice',
      type: RequestType.GET,
      params: params,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(AveragePrice.fromMap(r.right)));
  }

  /// 24 hour rolling window price change statistics. Careful when accessing this with no symbol.
  Future<Either<String, TickerStatistics>> get24hrTickerPriceChangeStatistics({
    required String symbol,
  }) {
    Map<String, String> params = {'symbol': symbol};
    return sendRequest(
      path: 'api/v3/ticker/24hr',
      type: RequestType.GET,
      params: params,
    ).then((r) =>
        r.isLeft ? Left(r.left) : Right(TickerStatistics.fromMap(r.right)));
  }

  /// 24 hour rolling window price change statistics for all symbols. Careful when accessing this with no symbol.
  Future<Either<String, List<TickerStatistics>>>
      getAll24hrTickerPriceChangeStatistics() {
    return sendRequest(
      path: 'api/v3/ticker/24hr',
      type: RequestType.GET,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<TickerStatistics>.from(
            r.right.map((e) => TickerStatistics.fromMap(e)))));
  }

  /// Latest price for a symbol
  Future<Either<String, Ticker>> symbolPriceTicker({
    required String symbol,
  }) {
    Map<String, String> params = {'symbol': symbol};
    return sendRequest(
      path: 'api/v3/ticker/price',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : Right(Ticker.fromMap(r.right)));
  }

  /// Latest price for all symbols
  Future<Either<String, List<Ticker>>> allSymbolsPriceTicker() {
    return sendRequest(
      path: 'api/v3/ticker/price',
      type: RequestType.GET,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Ticker>.from(r.right.map((e) => Ticker.fromMap(e)))));
  }

  /// Best price/qty on the order book for a symbol.
  Future<Either<String, BookTicker>> orderBookTicker({
    required String symbol,
  }) {
    Map<String, String> params = {'symbol': symbol};
    return sendRequest(
      path: 'api/v3/ticker/bookTicker',
      type: RequestType.GET,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : Right(BookTicker.fromMap(r.right)));
  }

  /// Best price/qty on the order book for all symbols.
  Future<Either<String, List<BookTicker>>> allOrderBookTicker() {
    return sendRequest(
      path: 'api/v3/ticker/bookTicker',
      type: RequestType.GET,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(
            List<BookTicker>.from(r.right.map((e) => BookTicker.fromMap(e)))));
  }
}
