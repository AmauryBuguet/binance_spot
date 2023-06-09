import 'package:flutter/foundation.dart';

enum Side {
  buy,
  sell,
}

extension SideExt on Side {
  String toStr() => describeEnum(this);
}

enum Interval {
  oneMinute,
  threeMinutes,
  fiveMinutes,
  fifteenMinutes,
  thirtyMinutes,
  oneHour,
  twoHours,
  fourHours,
  sixHours,
  eightHours,
  twelveHours,
  oneDay,
  threeDays,
  oneWeek,
  oneMonth,
}

enum TimeInForce {
  gtc,
  ioc,
  fok,
}

extension TimeInForceExt on TimeInForce {
  String toStr() => describeEnum(this);
}

extension IntervalExt on Interval {
  String toStr() => describeEnum(this).split("_").last;
}

enum OrderType {
  limit,
  market,
  stop,
  stopLoss,
  stopLossLimit,
  takeProfit,
  takeProfitLimit,
  limitMaker,
}

extension OrderTypeExt on OrderType {
  String toStr() => describeEnum(this);
}

enum OrderStatus {
  newOrder,
  partiallyFilled,
  filled,
  canceled,
  pendingCancel,
  rejected,
  expired,
}

extension OrderStatusExt on OrderStatus {
  String toStr() => describeEnum(this);
}

extension EnumExt on String {
  Side toSideEnum() => Side.values.firstWhere((s) => describeEnum(s) == this);
  Interval toIntervalEnum() => Interval.values.firstWhere((s) => describeEnum(s).split("_").last == this);
  TimeInForce toTimeInForceEnum() => TimeInForce.values.firstWhere((s) => describeEnum(s) == this);
  OrderType toOrderTypeEnum() => OrderType.values.firstWhere((s) => describeEnum(s) == this);
  OrderStatus toOrderStatusEnum() => OrderStatus.values.firstWhere((s) => describeEnum(s) == this);
}
