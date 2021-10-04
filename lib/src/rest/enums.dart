import 'package:flutter/foundation.dart';

enum RequestType {
  GET,
  POST,
  DELETE,
  PUT,
}

enum SymbolStatus {
  PRE_TRADING,
  TRADING,
  POST_TRADING,
  END_OF_DAY,
  HALT,
  AUCTION_MATCH,
  BREAK,
}

extension SymbolStatusExt on SymbolStatus {
  String toStr() => describeEnum(this);
}

enum OcoStatus {
  RESPONSE,
  EXEC_STARTED,
  ALL_DONE,
}

extension OcoStatusExt on OcoStatus {
  String toStr() => describeEnum(this);
}

enum OcoOrderStatus {
  EXECUTING,
  ALL_DONE,
  REJECT,
}

extension OcoOrderStatusExt on OcoOrderStatus {
  String toStr() => describeEnum(this);
}

extension EnumSpotExt on String {
  SymbolStatus toSymbolStatusEnum() =>
      SymbolStatus.values.firstWhere((s) => describeEnum(s) == this);
  OcoStatus toOcoStatusEnum() =>
      OcoStatus.values.firstWhere((s) => describeEnum(s) == this);
  OcoOrderStatus toOcoOrderStatusEnum() =>
      OcoOrderStatus.values.firstWhere((s) => describeEnum(s) == this);
}
