enum RequestType {
  getRequest,
  postRequest,
  deleteRequest,
  putRequest,
}

enum SymbolStatus {
  preTrading("PRE_TRADING"),
  trading("TRADING"),
  postTrading("POST_TRADING"),
  endOfDay("END_OF_DAY"),
  halt("HALT"),
  auctionMatch("AUCTION_MATCH"),
  breakStatus("BREAK");

  const SymbolStatus(this.str);

  static SymbolStatus fromString(String str) {
    return SymbolStatus.values.firstWhere((e) => e.str == str);
  }

  final String str;
}

enum OcoStatus {
  response("RESPONSE"),
  execStarted("EXEC_STARTED"),
  allDone("ALL_DONE");

  const OcoStatus(this.str);

  static OcoStatus fromString(String str) {
    return OcoStatus.values.firstWhere((e) => e.str == str);
  }

  final String str;
}

enum OcoOrderStatus {
  executing("EXECUTING"),
  allDone("ALL_DONE"),
  reject("REJECT");

  const OcoOrderStatus(this.str);

  static OcoOrderStatus fromString(String str) {
    return OcoOrderStatus.values.firstWhere((e) => e.str == str);
  }

  final String str;
}
