enum Side {
  buy("BUY"),
  sell("SELL");

  const Side(this.str);

  static Side fromString(String str) {
    return Side.values.firstWhere((e) => e.str == str);
  }

  final String str;
}

enum Interval {
  oneMinute("1m"),
  threeMinutes("3m"),
  fiveMinutes("5m"),
  fifteenMinutes("15m"),
  thirtyMinutes("30m"),
  oneHour("1h"),
  twoHours("2h"),
  fourHours("4h"),
  sixHours("6h"),
  eightHours("8h"),
  twelveHours("12h"),
  oneDay("1d"),
  threeDays("3d"),
  oneWeek("1w"),
  oneMonth("1M");

  const Interval(this.str);

  static Interval fromString(String str) {
    return Interval.values.firstWhere((e) => e.str == str);
  }

  final String str;
}

enum TimeInForce {
  gtc("GTC"),
  ioc("IOC"),
  fok("FOK");

  const TimeInForce(this.str);

  static TimeInForce fromString(String str) {
    return TimeInForce.values.firstWhere((e) => e.str == str);
  }

  final String str;
}

enum OrderType {
  limit("LIMIT"),
  market("MARKET"),
  stopLoss("STOP_LOSS"),
  stopLossLimit("STOP_LOSS_LIMIT"),
  takeProfit("TAKE_PROFIT"),
  takeProfitLimit("TAKE_PROFIT_LIMIT"),
  limitMaker("LIMIT_MAKER");

  const OrderType(this.str);

  static OrderType fromString(String str) {
    return OrderType.values.firstWhere((e) => e.str == str);
  }

  final String str;
}

enum OrderStatus {
  newOrder("NEW"),
  partiallyFilled("PARTIALLY_FILLED"),
  filled("FILLED"),
  canceled("CANCELED"),
  pendingCancel("PENDING_CANCEL"),
  rejected("REJECTED"),
  expired("EXPIRED"),
  expiredInMatch("EXPIRED_IN_MATCH");

  const OrderStatus(this.str);

  static OrderStatus fromString(String str) {
    return OrderStatus.values.firstWhere((e) => e.str == str);
  }

  final String str;
}
