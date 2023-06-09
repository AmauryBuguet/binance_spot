import 'package:flutter/foundation.dart';

enum RequestType {
  getRequest,
  postRequest,
  deleteRequest,
  putRequest,
}

enum SymbolStatus {
  preTrading,
  trading,
  postTrading,
  endOfDay,
  halt,
  auctionMatch,
  breakStatus,
}

extension SymbolStatusExt on SymbolStatus {
  String toStr() => describeEnum(this);
}

enum OcoStatus {
  response,
  execStarted,
  allDone,
}

extension OcoStatusExt on OcoStatus {
  String toStr() => describeEnum(this);
}

enum OcoOrderStatus {
  executing,
  allDone,
  reject,
}

extension OcoOrderStatusExt on OcoOrderStatus {
  String toStr() => describeEnum(this);
}

extension EnumSpotExt on String {
  SymbolStatus toSymbolStatusEnum() => SymbolStatus.values.firstWhere((s) => describeEnum(s) == this);
  OcoStatus toOcoStatusEnum() => OcoStatus.values.firstWhere((s) => describeEnum(s) == this);
  OcoOrderStatus toOcoOrderStatusEnum() => OcoOrderStatus.values.firstWhere((s) => describeEnum(s) == this);
}
