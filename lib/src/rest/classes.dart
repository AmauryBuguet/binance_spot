import 'enums.dart';

import '../common/classes.dart';
import '../common/enums.dart';

class Symbol {
  String symbol;
  SymbolStatus status;
  String baseAsset;
  int baseAssetPrecision;
  String quoteAsset;
  int quotePrecision;
  int quoteAssetPrecision;
  List<OrderType> orderTypes;
  bool icebergAllowed;
  bool ocoAllowed;
  bool isSpotTradingAllowed;
  bool isMarginTradingAllowed;
  List<dynamic> filters;
  List<String> permissions;

  Symbol.fromMap(Map m)
      : symbol = m['symbol'],
        status = (m['status'] as String).toSymbolStatusEnum(),
        baseAsset = m['baseAsset'],
        baseAssetPrecision = m['baseAssetPrecision'],
        quoteAsset = m['quoteAsset'],
        quotePrecision = m['quotePrecision'],
        quoteAssetPrecision = m['quoteAssetPrecision'],
        orderTypes = (m['orderTypes'] as List<dynamic>)
            .cast<String>()
            .map((String e) => e.toOrderTypeEnum())
            .toList(),
        icebergAllowed = m['icebergAllowed'],
        ocoAllowed = m['ocoAllowed'],
        isSpotTradingAllowed = m['isSpotTradingAllowed'],
        isMarginTradingAllowed = m['isMarginTradingAllowed'],
        filters = m['filters'],
        permissions = m['permissions'].cast<String>();
}

class ExchangeInfo {
  String timezone;
  int serverTime;
  List<dynamic> rateLimits;
  List<dynamic> exchangeFilters;
  List<Symbol> symbols;

  ExchangeInfo.fromMap(Map m)
      : timezone = m['timezone'],
        serverTime = m['serverTime'],
        rateLimits = m['rateLimits'],
        exchangeFilters = m['exchangeFilters'],
        symbols = (m['symbols'] as List<dynamic>)
            .map((e) => Symbol.fromMap(e))
            .toList();
}

class OrderBook {
  int lastUpdateId;
  int messageOutputTime;
  int transactionTime;
  List<DepthOrder> bids;
  List<DepthOrder> asks;

  OrderBook.fromMap(Map m)
      : lastUpdateId = m['lastUpdateId'],
        messageOutputTime = m['E'],
        transactionTime = m['T'],
        bids = (m['bids'] as List<dynamic>)
            .map((e) => DepthOrder.fromList(e))
            .toList(),
        asks = (m['asks'] as List<dynamic>)
            .map((e) => DepthOrder.fromList(e))
            .toList();
}

class Trade {
  int id;
  double price;
  double qty;
  double quoteQty;
  int time;
  bool isBuyerMaker;

  Trade.fromMap(Map m)
      : id = m['id'],
        price = double.parse(m['price']),
        qty = double.parse(m['qty']),
        quoteQty = double.parse(m['quoteQty']),
        time = m['time'],
        isBuyerMaker = m['isBuyerMaker'];
}

class Kline {
  int timestamp;
  double open;
  double high;
  double low;
  double close;
  double volume;
  int closeTimestamp;
  double quoteAssetVolume;
  int tradeNumber;
  double takerBuyBaseAssetVolume;
  double takerBuyQuoteAssetVolume;

  Kline.fromList(List l)
      : timestamp = l[0],
        open = double.parse(l[1]),
        high = double.parse(l[2]),
        low = double.parse(l[3]),
        close = double.parse(l[4]),
        volume = double.parse(l[5]),
        closeTimestamp = l[6],
        quoteAssetVolume = double.parse(l[7]),
        tradeNumber = l[8],
        takerBuyBaseAssetVolume = double.parse(l[9]),
        takerBuyQuoteAssetVolume = double.parse(l[10]);
}

class AveragePrice {
  int mins;
  double price;

  AveragePrice.fromMap(Map m)
      : mins = m['mins'],
        price = double.parse(m['price']);
}

class TickerStatistics {
  String symbol;
  double priceChange;
  double priceChangePercent;
  double weightedAvgPrice;
  double prevClosePrice;
  double lastPrice;
  double lastQty;
  double bidPrice;
  double askPrice;
  double openPrice;
  double highPrice;
  double lowPrice;
  double volume;
  double quoteVolume;
  int openTime;
  int closeTime;
  int firstId;
  int lastId;
  int count;

  TickerStatistics.fromMap(Map m)
      : symbol = m['symbol'],
        priceChange = double.parse(m['priceChange']),
        priceChangePercent = double.parse(m['priceChangePercent']),
        weightedAvgPrice = double.parse(m['weightedAvgPrice']),
        prevClosePrice = double.parse(m['prevClosePrice']),
        lastPrice = double.parse(m['lastPrice']),
        lastQty = double.parse(m['lastQty']),
        bidPrice = double.parse(m['bidPrice']),
        askPrice = double.parse(m['askPrice']),
        openPrice = double.parse(m['openPrice']),
        highPrice = double.parse(m['highPrice']),
        lowPrice = double.parse(m['lowPrice']),
        volume = double.parse(m['volume']),
        quoteVolume = double.parse(m['quoteVolume']),
        openTime = m['openTime'],
        closeTime = m['closeTime'],
        firstId = m['firstId'],
        lastId = m['lastId'],
        count = m['count'];
}

class Ticker {
  String symbol;
  double price;

  Ticker.fromMap(Map m)
      : symbol = m['symbol'],
        price = double.parse(m['price']);
}

class BookTicker {
  String symbol;
  double bidPrice;
  double bidQty;
  double askPrice;
  double askQty;

  BookTicker.fromMap(Map m)
      : symbol = m['symbol'],
        bidPrice = double.parse(m['bidPrice']),
        bidQty = double.parse(m['bidQty']),
        askPrice = double.parse(m['askPrice']),
        askQty = double.parse(m['askQty']);
}

class Order {
  String symbol;
  int orderId;
  int orderListId;
  String clientOrderId;
  int transactTime;
  double price;
  double origQty;
  double executedQty;
  double cummulativeQuoteQty;
  OrderStatus status;
  TimeInForce timeInForce;
  OrderType type;
  Side side;
  double? stopPrice;

  Order.fromMap(Map m)
      : symbol = m['symbol'],
        orderId = m['orderId'],
        orderListId = m['orderListId'],
        clientOrderId = m['clientOrderId'],
        transactTime = m['transactTime'],
        price = double.parse(m['price']),
        origQty = double.parse(m['origQty']),
        executedQty = double.parse(m['executedQty']),
        cummulativeQuoteQty = double.parse(m['cummulativeQuoteQty']),
        status = (m['status'] as String).toOrderStatusEnum(),
        timeInForce = (m['timeInForce'] as String).toTimeInForceEnum(),
        type = (m['type'] as String).toOrderTypeEnum(),
        side = (m['side'] as String).toSideEnum(),
        stopPrice = m['stopPrice'];
}

class CanceledOrder {
  String symbol;
  String origClientOrderId;
  int orderId;
  int orderListId;
  String clientOrderId;
  double price;
  double origQty;
  double executedQty;
  double cummulativeQuoteQty;
  OrderStatus status;
  TimeInForce timeInForce;
  OrderType type;
  Side side;

  CanceledOrder.fromMap(Map m)
      : symbol = m['symbol'],
        origClientOrderId = m['origClientOrderId'],
        orderId = m['orderId'],
        orderListId = m['orderListId'],
        clientOrderId = m['clientOrderId'],
        price = double.parse(m['price']),
        origQty = double.parse(m['origQty']),
        executedQty = double.parse(m['executedQty']),
        cummulativeQuoteQty = double.parse(m['cummulativeQuoteQty']),
        status = (m['status'] as String).toOrderStatusEnum(),
        timeInForce = (m['timeInForce'] as String).toTimeInForceEnum(),
        type = (m['type'] as String).toOrderTypeEnum(),
        side = (m['side'] as String).toSideEnum();
}

class CurrentOrder {
  String symbol;
  int orderId;
  int orderListId;
  String clientOrderId;
  double price;
  double origQty;
  double executedQty;
  double cummulativeQuoteQty;
  OrderStatus status;
  TimeInForce timeInForce;
  OrderType type;
  Side side;
  double stopPrice;
  double icebergQty;
  int time;
  int updateTime;
  bool isWorking;
  double origQuoteOrderQty;

  CurrentOrder.fromMap(Map m)
      : symbol = m['symbol'],
        orderId = m['orderId'],
        orderListId = m['orderListId'],
        clientOrderId = m['clientOrderId'],
        price = double.parse(m['price']),
        origQty = double.parse(m['origQty']),
        executedQty = double.parse(m['executedQty']),
        cummulativeQuoteQty = double.parse(m['cummulativeQuoteQty']),
        status = (m['status'] as String).toOrderStatusEnum(),
        timeInForce = (m['timeInForce'] as String).toTimeInForceEnum(),
        type = (m['type'] as String).toOrderTypeEnum(),
        side = (m['side'] as String).toSideEnum(),
        stopPrice = double.parse(m['stopPrice']),
        icebergQty = double.parse(m['icebergQty']),
        time = m['time'],
        updateTime = m['updateTime'],
        isWorking = m['isWorking'],
        origQuoteOrderQty = double.parse(m['origQuoteOrderQty']);
}

class OrderInfo {
  String symbol;
  int orderId;
  String clientOrderId;

  OrderInfo.fromMap(Map m)
      : symbol = m['symbol'],
        orderId = m['orderId'],
        clientOrderId = m['clientOrderId'];
}

class OcoOrder {
  int orderListId;
  String contingencyType;
  OcoStatus listStatusType;
  OcoOrderStatus listOrderStatus;
  String listClientOrderId;
  int transactionTime;
  String symbol;
  List<OrderInfo> orders;
  List<Order> orderReports;

  OcoOrder.fromMap(Map m)
      : orderListId = m['orderListId'],
        contingencyType = m['contingencyType'],
        listStatusType = (m['listStatusType'] as String).toOcoStatusEnum(),
        listOrderStatus =
            (m['listOrderStatus'] as String).toOcoOrderStatusEnum(),
        listClientOrderId = m['listClientOrderId'],
        transactionTime = m['transactionTime'],
        symbol = m['symbol'],
        orders = (m['orders'] as List<dynamic>)
            .map((e) => OrderInfo.fromMap(e))
            .toList(),
        orderReports = m.containsKey('orderReports')
            ? (m['orderReports'] as List<dynamic>)
                .map((e) => Order.fromMap(e))
                .toList()
            : [];
}

class AccountInfo {
  int makerCommission;
  int takerCommission;
  int buyerCommission;
  int sellerCommission;
  bool canTrade;
  bool canWithdraw;
  bool canDeposit;
  int updateTime;
  String accountType;
  List<Balance> balances;
  List<String> permissions;

  AccountInfo.fromMap(Map m)
      : makerCommission = m['makerCommission'],
        takerCommission = m['takerCommission'],
        buyerCommission = m['buyerCommission'],
        sellerCommission = m['sellerCommission'],
        canTrade = m['canTrade'],
        canWithdraw = m['canWithdraw'],
        canDeposit = m['canDeposit'],
        updateTime = m['updateTime'],
        accountType = m['accountType'],
        balances = (m['balances'] as List<dynamic>)
            .map((e) => Balance.fromMap(e))
            .toList(),
        permissions = m['permissions'].cast<String>();
}

class AccountTrade {
  String symbol;
  int id;
  int orderId;
  int orderListId;
  double price;
  double qty;
  double quoteQty;
  double commission;
  String commissionAsset;
  int time;
  bool isBuyer;
  bool isMaker;
  bool isBestMatch;

  AccountTrade.fromMap(Map m)
      : symbol = m['symbol'],
        id = m['id'],
        orderId = m['orderId'],
        orderListId = m['orderListId'],
        price = double.parse(m['price']),
        qty = double.parse(m['qty']),
        quoteQty = double.parse(m['quoteQty']),
        commission = double.parse(m['commission']),
        commissionAsset = m['commissionAsset'],
        time = m['time'],
        isBuyer = m['isBuyer'],
        isMaker = m['isMaker'],
        isBestMatch = m['isBestMatch'];
}

class FiatTransferData {
  String orderNo;
  String fiatCurrency;
  double indicatedAmount;
  double amount;
  double totalFee;
  String method;
  String status;
  int createTime;
  int updateTime;

  FiatTransferData.fromMap(Map m)
      : orderNo = m['orderNo'],
        fiatCurrency = m['fiatCurrency'],
        indicatedAmount = double.parse(m['indicatedAmount']),
        amount = double.parse(m['amount']),
        totalFee = double.parse(m['totalFee']),
        method = m['method'],
        status = m['status'],
        createTime = m['createTime'],
        updateTime = m['updateTime'];
}

class FiatTransferHistory {
  double code;
  String message;
  List<FiatTransferData> data;
  int total;
  bool success;

  FiatTransferHistory.fromMap(Map m)
      : code = double.parse(m['code']),
        message = m['message'],
        data = (m['data'] as List<dynamic>)
            .map((e) => FiatTransferData.fromMap(e))
            .toList(),
        total = m['total'],
        success = m['success'];
}

class FiatPaymentData {
  String orderNo;
  double sourceAmount;
  String fiatCurrency;
  double obtainAmount;
  String cryptoCurrency;
  double totalFee;
  double price;
  String status;
  int createTime;
  int updateTime;

  FiatPaymentData.fromMap(Map m)
      : orderNo = m['orderNo'],
        sourceAmount = double.parse(m['sourceAmount']),
        fiatCurrency = m['fiatCurrency'],
        obtainAmount = double.parse(m['obtainAmount']),
        cryptoCurrency = m['cryptoCurrency'],
        totalFee = double.parse(m['totalFee']),
        price = double.parse(m['price']),
        status = m['status'],
        createTime = m['createTime'],
        updateTime = m['updateTime'];
}

class FiatPaymentHistory {
  double code;
  String message;
  List<FiatPaymentData> data;
  int total;
  bool success;

  FiatPaymentHistory.fromMap(Map m)
      : code = double.parse(m['code']),
        message = m['message'],
        data = (m['data'] as List<dynamic>)
            .map((e) => FiatPaymentData.fromMap(e))
            .toList(),
        total = m['total'],
        success = m['success'];
}

class SubaccountInfo {
  String email;
  bool isFreeze;
  int createTime;

  SubaccountInfo.fromMap(Map m)
      : email = m['email'],
        isFreeze = m['isFreeze'],
        createTime = m['createTime'];
}

class SubaccountList {
  List<SubaccountInfo> subAccounts;

  SubaccountList.fromMap(Map m)
      : subAccounts = (m['subAccounts'] as List<dynamic>)
            .map((e) => SubaccountInfo.fromMap(e))
            .toList();
}

class SubaccountTransfer {
  String from;
  String to;
  String asset;
  double qty;
  String status;
  int tranId;
  int time;

  SubaccountTransfer.fromMap(Map m)
      : from = m['from'],
        to = m['to'],
        asset = m['asset'],
        qty = double.parse(m['qty']),
        status = m['status'] ?? "",
        tranId = m['tranId'],
        time = m['time'];
}

class SubaccountFuturesTransferHistory {
  bool success;
  int futuresType;
  List<SubaccountTransfer> transfers;

  SubaccountFuturesTransferHistory.fromMap(Map m)
      : success = m['success'],
        futuresType = m['futuresType'],
        transfers = (m['transfers'] as List<dynamic>)
            .map((e) => SubaccountTransfer.fromMap(e))
            .toList();
}

class SubaccountFuturesTransfer {
  bool success;
  double txnId;

  SubaccountFuturesTransfer.fromMap(Map m)
      : success = m['success'],
        txnId = double.parse(m['txnId']);
}

class SubaccountBalances {
  List<Balance> balances;

  SubaccountBalances.fromMap(Map m)
      : balances = (m['balances'] as List<dynamic>)
            .map((e) => Balance.fromMap(e))
            .toList();
}

class SubaccountBtcValued {
  String email;
  double totalAsset;

  SubaccountBtcValued.fromMap(Map m)
      : email = m['email'],
        totalAsset = double.parse(m['totalAsset']);
}

class SubaccountSpotAssetsSummary {
  int totalCount;
  double masterAccountTotalAsset;
  List<SubaccountBtcValued> spotSubUserAssetBtcVoList;

  SubaccountSpotAssetsSummary.fromMap(Map m)
      : totalCount = m['totalCount'],
        masterAccountTotalAsset = double.parse(m['masterAccountTotalAsset']),
        spotSubUserAssetBtcVoList =
            (m['spotSubUserAssetBtcVoList'] as List<dynamic>)
                .map((e) => SubaccountBtcValued.fromMap(e))
                .toList();
}

class DepositAddress {
  String address;
  String coin;
  String tag;
  String url;

  DepositAddress.fromMap(Map m)
      : address = m['address'],
        coin = m['coin'],
        tag = m['tag'],
        url = m['url'];
}

class Deposit {
  double amount;
  String coin;
  String network;
  int status;
  String address;
  String addressTag;
  String txId;
  int insertTime;
  int transferType;
  String unlockConfirm;
  String confirmTimes;

  Deposit.fromMap(Map m)
      : amount = double.parse(m['amount']),
        coin = m['coin'],
        network = m['network'],
        status = m['status'],
        address = m['address'],
        addressTag = m['addressTag'],
        txId = m['txId'],
        insertTime = m['insertTime'],
        transferType = m['transferType'],
        unlockConfirm = m['unlockConfirm'] ?? "",
        confirmTimes = m['confirmTimes'];
}

class SubaccountStatus {
  String email;
  bool isSubUserEnabled;
  bool isUserActive;
  int insertTime;
  bool isMarginEnabled;
  bool isFutureEnabled;
  int mobile;

  SubaccountStatus.fromMap(Map m)
      : email = m['email'],
        isSubUserEnabled = m['isSubUserEnabled'],
        isUserActive = m['isUserActive'],
        insertTime = m['insertTime'],
        isMarginEnabled = m['isMarginEnabled'],
        isFutureEnabled = m['isFutureEnabled'],
        mobile = m['mobile'];
}

class SubaccountMarginCoeff {
  double forceLiquidationBar;
  double marginCallBar;
  double normalBar;

  SubaccountMarginCoeff.fromMap(Map m)
      : forceLiquidationBar = double.parse(m['forceLiquidationBar']),
        marginCallBar = double.parse(m['marginCallBar']),
        normalBar = double.parse(m['normalBar']);
}

class MarginBalance {
  String asset;
  double borrowed;
  double free;
  double interest;
  double locked;
  double netAsset;

  MarginBalance.fromMap(Map m)
      : asset = m['asset'],
        borrowed = double.parse(m['borrowed']),
        free = double.parse(m['free']),
        interest = double.parse(m['interest']),
        locked = double.parse(m['locked']),
        netAsset = double.parse(m['netAsset']);
}

class SubaccountMarginDetail {
  String email;
  double marginLevel;
  double totalAssetOfBtc;
  double totalLiabilityOfBtc;
  double totalNetAssetOfBtc;
  List<SubaccountMarginCoeff> marginTradeCoeffVo;
  List<MarginBalance> marginUserAssetVoList;

  SubaccountMarginDetail.fromMap(Map m)
      : email = m['email'],
        marginLevel = double.parse(m['marginLevel']),
        totalAssetOfBtc = double.parse(m['totalAssetOfBtc']),
        totalLiabilityOfBtc = double.parse(m['totalLiabilityOfBtc']),
        totalNetAssetOfBtc = double.parse(m['totalNetAssetOfBtc']),
        marginTradeCoeffVo = (m['marginTradeCoeffVo'] as List<dynamic>)
            .map((e) => SubaccountMarginCoeff.fromMap(e))
            .toList(),
        marginUserAssetVoList = (m['marginUserAssetVoList'] as List<dynamic>)
            .map((e) => MarginBalance.fromMap(e))
            .toList();
}

class SubaccountMarginSummary {
  String email;
  double totalAssetOfBtc;
  double totalLiabilityOfBtc;
  double totalNetAssetOfBtc;

  SubaccountMarginSummary.fromMap(Map m)
      : email = m['email'],
        totalAssetOfBtc = double.parse(m['totalAssetOfBtc']),
        totalLiabilityOfBtc = double.parse(m['totalLiabilityOfBtc']),
        totalNetAssetOfBtc = double.parse(m['totalNetAssetOfBtc']);
}

class AllSubaccountMarginSummary {
  double totalAssetOfBtc;
  double totalLiabilityOfBtc;
  double totalNetAssetOfBtc;
  List<SubaccountMarginSummary> subAccountList;

  AllSubaccountMarginSummary.fromMap(Map m)
      : totalAssetOfBtc = double.parse(m['totalAssetOfBtc']),
        totalLiabilityOfBtc = double.parse(m['totalLiabilityOfBtc']),
        totalNetAssetOfBtc = double.parse(m['totalNetAssetOfBtc']),
        subAccountList = (m['subAccountList'] as List<dynamic>)
            .map((e) => SubaccountMarginSummary.fromMap(e))
            .toList();
}

class SubaccountFuturesAsset {
  String asset;
  double initialMargin;
  double maintenanceMargin;
  double marginBalance;
  double maxWithdrawAmount;
  double openOrderInitialMargin;
  double positionInitialMargin;
  double unrealizedProfit;
  double walletBalance;

  SubaccountFuturesAsset.fromMap(Map m)
      : asset = m['asset'],
        initialMargin = double.parse(m['initialMargin']),
        maintenanceMargin = double.parse(m['maintenanceMargin']),
        marginBalance = double.parse(m['marginBalance']),
        maxWithdrawAmount = double.parse(m['maxWithdrawAmount']),
        openOrderInitialMargin = double.parse(m['openOrderInitialMargin']),
        positionInitialMargin = double.parse(m['positionInitialMargin']),
        unrealizedProfit = double.parse(m['unrealizedProfit']),
        walletBalance = double.parse(m['walletBalance']);
}

class SubaccountFuturesDetail {
  String email;
  String asset;
  List<SubaccountFuturesAsset> assets;
  bool canDeposit;
  bool canTrade;
  bool canWithdraw;
  int feeTier;
  double maxWithdrawAmount;
  double totalInitialMargin;
  double totalMaintenanceMargin;
  double totalMarginBalance;
  double totalOpenOrderInitialMargin;
  double totalPositionInitialMargin;
  double totalUnrealizedProfit;
  double totalWalletBalance;
  int updateTime;

  SubaccountFuturesDetail.fromMap(Map m)
      : email = m['email'],
        asset = m['asset'],
        assets = (m['assets'] as List<dynamic>)
            .map((e) => SubaccountFuturesAsset.fromMap(e))
            .toList(),
        canDeposit = m['canDeposit'],
        canTrade = m['canTrade'],
        canWithdraw = m['canWithdraw'],
        feeTier = m['feeTier'],
        maxWithdrawAmount = double.parse(m['maxWithdrawAmount']),
        totalInitialMargin = double.parse(m['totalInitialMargin']),
        totalMaintenanceMargin = double.parse(m['totalMaintenanceMargin']),
        totalMarginBalance = double.parse(m['totalMarginBalance']),
        totalOpenOrderInitialMargin =
            double.parse(m['totalOpenOrderInitialMargin']),
        totalPositionInitialMargin =
            double.parse(m['totalPositionInitialMargin']),
        totalUnrealizedProfit = double.parse(m['totalUnrealizedProfit']),
        totalWalletBalance = double.parse(m['totalWalletBalance']),
        updateTime = m['updateTime'];
}

class SubaccountFuturesSummary {
  String email;
  double totalInitialMargin;
  double totalMaintenanceMargin;
  double totalMarginBalance;
  double totalOpenOrderInitialMargin;
  double totalPositionInitialMargin;
  double totalUnrealizedProfit;
  double totalWalletBalance;
  String asset;

  SubaccountFuturesSummary.fromMap(Map m)
      : email = m['email'],
        totalInitialMargin = double.parse(m['totalInitialMargin']),
        totalMaintenanceMargin = double.parse(m['totalMaintenanceMargin']),
        totalMarginBalance = double.parse(m['totalMarginBalance']),
        totalOpenOrderInitialMargin =
            double.parse(m['totalOpenOrderInitialMargin']),
        totalPositionInitialMargin =
            double.parse(m['totalPositionInitialMargin']),
        totalUnrealizedProfit = double.parse(m['totalUnrealizedProfit']),
        totalWalletBalance = double.parse(m['totalWalletBalance']),
        asset = m['asset'];
}

class AllSubaccountFuturesSummary {
  double totalInitialMargin;
  double totalMaintenanceMargin;
  double totalMarginBalance;
  double totalOpenOrderInitialMargin;
  double totalPositionInitialMargin;
  double totalUnrealizedProfit;
  double totalWalletBalance;
  String asset;
  List<SubaccountFuturesSummary> subAccountList;

  AllSubaccountFuturesSummary.fromMap(Map m)
      : totalInitialMargin = double.parse(m['totalInitialMargin']),
        totalMaintenanceMargin = double.parse(m['totalMaintenanceMargin']),
        totalMarginBalance = double.parse(m['totalMarginBalance']),
        totalOpenOrderInitialMargin =
            double.parse(m['totalOpenOrderInitialMargin']),
        totalPositionInitialMargin =
            double.parse(m['totalPositionInitialMargin']),
        totalUnrealizedProfit = double.parse(m['totalUnrealizedProfit']),
        totalWalletBalance = double.parse(m['totalWalletBalance']),
        asset = m['asset'],
        subAccountList = (m['subAccountList'] as List<dynamic>)
            .map((e) => SubaccountFuturesSummary.fromMap(e))
            .toList();
}

class SubaccountFuturesPositionRisk {
  double entryPrice;
  double leverage;
  double maxNotional;
  double liquidationPrice;
  double markPrice;
  double positionAmount;
  String symbol;
  double unrealizedProfit;

  SubaccountFuturesPositionRisk.fromMap(Map m)
      : entryPrice = double.parse(m['entryPrice']),
        leverage = double.parse(m['leverage']),
        maxNotional = double.parse(m['maxNotional']),
        liquidationPrice = double.parse(m['liquidationPrice']),
        markPrice = double.parse(m['markPrice']),
        positionAmount = double.parse(m['positionAmount']),
        symbol = m['symbol'],
        unrealizedProfit = double.parse(m['unrealizedProfit']);
}

class SubaccountTransferData {
  String counterParty;
  String email;
  int type;
  String asset;
  double qty;
  String fromAccountType;
  String toAccountType;
  String status;
  int tranId;
  int time;

  SubaccountTransferData.fromMap(Map m)
      : counterParty = m['counterParty'],
        email = m['email'],
        type = m['type'],
        asset = m['asset'],
        qty = double.parse(m['qty']),
        fromAccountType = m['fromAccountType'],
        toAccountType = m['toAccountType'],
        status = m['status'],
        tranId = m['tranId'],
        time = m['time'];
}

class SubaccountUniversalTransfer {
  int tranId;
  String fromEmail;
  String toEmail;
  String asset;
  double amount;
  String fromAccountType;
  String toAccountType;
  String status;
  int createTimeStamp;

  SubaccountUniversalTransfer.fromMap(Map m)
      : tranId = m['tranId'],
        fromEmail = m['fromEmail'],
        toEmail = m['toEmail'],
        asset = m['asset'],
        amount = double.parse(m['amount']),
        fromAccountType = m['fromAccountType'],
        toAccountType = m['toAccountType'],
        status = m['status'],
        createTimeStamp = m['createTimeStamp'];
}

class ManagedSubaccountAsset {
  String coin;
  String name;
  double totalBalance;
  double availableBalance;
  double inOrder;
  double btcValue;

  ManagedSubaccountAsset.fromMap(Map m)
      : coin = m['coin'],
        name = m['name'],
        totalBalance = double.parse(m['totalBalance']),
        availableBalance = double.parse(m['availableBalance']),
        inOrder = double.parse(m['inOrder']),
        btcValue = double.parse(m['btcValue']);
}

class SystemStatus {
  int status;
  String msg;

  SystemStatus.fromMap(Map m)
      : status = m['status'],
        msg = m['msg'];
}

class Network {
  String addressRegex;
  String coin;
  String depositDesc;
  bool depositEnable;
  bool isDefault;
  String memoRegex;
  int minConfirm;
  String name;
  String network;
  bool resetAddressStatus;
  String specialTips;
  int unLockConfirm;
  String withdrawDesc;
  bool withdrawEnable;
  double withdrawFee;
  double withdrawIntegerMultiple;
  double withdrawMax;
  double withdrawMin;
  bool sameAddress;

  Network.fromMap(Map m)
      : addressRegex = m['addressRegex'],
        coin = m['coin'],
        depositDesc = m['depositDesc'],
        depositEnable = m['depositEnable'],
        isDefault = m['isDefault'],
        memoRegex = m['memoRegex'],
        minConfirm = m['minConfirm'],
        name = m['name'],
        network = m['network'],
        resetAddressStatus = m['resetAddressStatus'],
        specialTips = m['specialTips'],
        unLockConfirm = m['unLockConfirm'],
        withdrawDesc = m['withdrawDesc'],
        withdrawEnable = m['withdrawEnable'],
        withdrawFee = double.parse(m['withdrawFee']),
        withdrawIntegerMultiple = double.parse(m['withdrawIntegerMultiple']),
        withdrawMax = double.parse(m['withdrawMax']),
        withdrawMin = double.parse(m['withdrawMin']),
        sameAddress = m['sameAddress'];
}

class CoinData {
  String coin;
  bool depositAllEnable;
  double free;
  double freeze;
  double ipoable;
  double ipoing;
  bool isLegalMoney;
  double locked;
  String name;
  List<Network> networkList;
  double storage;
  bool trading;
  bool withdrawAllEnable;
  double withdrawing;

  CoinData.fromMap(Map m)
      : coin = m['coin'],
        depositAllEnable = m['depositAllEnable'],
        free = double.parse(m['free']),
        freeze = double.parse(m['freeze']),
        ipoable = double.parse(m['ipoable']),
        ipoing = double.parse(m['ipoing']),
        isLegalMoney = m['isLegalMoney'],
        locked = double.parse(m['locked']),
        name = m['name'],
        networkList = (m['networkList'] as List<dynamic>)
            .map((e) => Network.fromMap(e))
            .toList(),
        storage = double.parse(m['storage']),
        trading = m['trading'],
        withdrawAllEnable = m['withdrawAllEnable'],
        withdrawing = double.parse(m['withdrawing']);
}

class SnapshotData {
  List<Balance> balances;
  double totalAssetOfBtc;

  SnapshotData.fromMap(Map m)
      : balances = (m['balances'] as List<dynamic>)
            .map((e) => Balance.fromMap(e))
            .toList(),
        totalAssetOfBtc = double.parse(m['totalAssetOfBtc']);
}

class SnapshotVos {
  SnapshotData data;
  String type;
  int updateTime;

  SnapshotVos.fromMap(Map m)
      : data = SnapshotData.fromMap(m['data']),
        type = m['type'],
        updateTime = m['updateTime'];
}

class Snapshots {
  int code;
  String msg;
  List<SnapshotVos> snapshotVos;

  Snapshots.fromMap(Map m)
      : code = m['code'],
        msg = m['msg'],
        snapshotVos = (m['snapshotVos'] as List<dynamic>)
            .map((e) => SnapshotVos.fromMap(e))
            .toList();
}

class SnapshotMarginData {
  double marginLevel;
  double totalAssetOfBtc;
  double totalLiabilityOfBtc;
  double totalNetAssetOfBtc;
  List<MarginBalance> userAssets;

  SnapshotMarginData.fromMap(Map m)
      : marginLevel = double.parse(m['marginLevel']),
        totalAssetOfBtc = double.parse(m['totalAssetOfBtc']),
        totalLiabilityOfBtc = double.parse(m['totalLiabilityOfBtc']),
        totalNetAssetOfBtc = double.parse(m['totalNetAssetOfBtc']),
        userAssets = (m['userAssets'] as List<dynamic>)
            .map((e) => MarginBalance.fromMap(e))
            .toList();
}

class SnapshotVosMargin {
  SnapshotMarginData data;
  String type;
  int updateTime;

  SnapshotVosMargin.fromMap(Map m)
      : data = SnapshotMarginData.fromMap(m['data']),
        type = m['type'],
        updateTime = m['updateTime'];
}

class SnapshotsMargin {
  int code;
  String msg;
  List<SnapshotVosMargin> snapshotVos;

  SnapshotsMargin.fromMap(Map m)
      : code = m['code'],
        msg = m['msg'],
        snapshotVos = (m['snapshotVos'] as List<dynamic>)
            .map((e) => SnapshotVosMargin.fromMap(e))
            .toList();
}

class FuturesBalance {
  String asset;
  double marginBalance;
  double walletBalance;

  FuturesBalance.fromMap(Map m)
      : asset = m['asset'],
        marginBalance = double.parse(m['marginBalance']),
        walletBalance = double.parse(m['walletBalance']);
}

class FuturesPosition {
  double entryPrice;
  double markPrice;
  double positionAmt;
  String symbol;
  double unRealizedProfit;

  FuturesPosition.fromMap(Map m)
      : entryPrice = double.parse(m['entryPrice']),
        markPrice = double.parse(m['markPrice']),
        positionAmt = double.parse(m['positionAmt']),
        symbol = m['symbol'],
        unRealizedProfit = double.parse(m['unRealizedProfit']);
}

class SnapshotFuturesData {
  List<FuturesBalance> assets;
  List<FuturesPosition> position;

  SnapshotFuturesData.fromMap(Map m)
      : assets = (m['assets'] as List<dynamic>)
            .map((e) => FuturesBalance.fromMap(e))
            .toList(),
        position = (m['position'] as List<dynamic>)
            .map((e) => FuturesPosition.fromMap(e))
            .toList();
}

class SnapshotVosFutures {
  SnapshotFuturesData data;
  String type;
  int updateTime;

  SnapshotVosFutures.fromMap(Map m)
      : data = SnapshotFuturesData.fromMap(m['data']),
        type = m['type'],
        updateTime = m['updateTime'];
}

class SnapshotsFutures {
  int code;
  String msg;
  List<SnapshotVosFutures> snapshotVos;

  SnapshotsFutures.fromMap(Map m)
      : code = m['code'],
        msg = m['msg'],
        snapshotVos = (m['snapshotVos'] as List<dynamic>)
            .map((e) => SnapshotVosFutures.fromMap(e))
            .toList();
}

class Withdraw {
  String address;
  double amount;
  String applyTime;
  String coin;
  String id;
  String withdrawOrderId;
  String network;
  int transferType;
  int status;
  double transactionFee;
  int confirmNo;
  String txId;

  Withdraw.fromMap(Map m)
      : address = m['address'],
        amount = double.parse(m['amount']),
        applyTime = m['applyTime'],
        coin = m['coin'],
        id = m['id'],
        withdrawOrderId = m['withdrawOrderId'],
        network = m['network'],
        transferType = m['transferType'],
        status = m['status'],
        transactionFee = double.parse(m['transactionFee']),
        confirmNo = m['confirmNo'],
        txId = m['txId'];
}

class ICVT {
  String i;
  int c;
  double v;
  double t;

  ICVT.fromMap(Map m)
      : i = m['i'],
        c = m['c'],
        v = double.parse(m['v']),
        t = double.parse(m['t']);
}

class ApiTradingIndicator {
  String name;
  ICVT ufr;
  ICVT ifer;
  ICVT gcr;

  ApiTradingIndicator.fromEntry(MapEntry e)
      : name = e.key,
        ufr = ICVT.fromMap(e.value[0]),
        ifer = ICVT.fromMap(e.value[1]),
        gcr = ICVT.fromMap(e.value[2]);
}

class AccountApiTradingData {
  bool isLocked;
  int plannedRecoverTime;
  Map<String, int> triggerCondition;
  List<ApiTradingIndicator> indicators;
  int updateTime;

  AccountApiTradingData.fromMap(Map m)
      : isLocked = m['isLocked'],
        plannedRecoverTime = m['plannedRecoverTime'],
        triggerCondition = m['triggerCondition'],
        indicators = (m['indicators'] as Map<String, dynamic>)
            .entries
            .map((e) => ApiTradingIndicator.fromEntry(e))
            .toList(),
        updateTime = m['updateTime'];
}

class DribbletDetail {
  int transId;
  double serviceChargeAmount;
  double amount;
  int operateTime;
  double transferedAmount;
  String fromAsset;

  DribbletDetail.fromMap(Map m)
      : transId = m['transId'] ?? m['tranId'],
        serviceChargeAmount = double.parse(m['serviceChargeAmount']),
        amount = double.parse(m['amount']),
        operateTime = m['operateTime'],
        transferedAmount = double.parse(m['transferedAmount']),
        fromAsset = m['fromAsset'];
}

class Dribblet {
  int operateTime;
  double totalTransferedAmount;
  double totalServiceChargeAmount;
  int transId;
  List<DribbletDetail> userAssetDribbletDetails;

  Dribblet.fromMap(Map m)
      : operateTime = m['operateTime'],
        totalTransferedAmount = double.parse(m['totalTransferedAmount']),
        totalServiceChargeAmount = double.parse(m['totalServiceChargeAmount']),
        transId = m['transId'],
        userAssetDribbletDetails =
            (m['userAssetDribbletDetails'] as List<dynamic>)
                .map((e) => DribbletDetail.fromMap(e))
                .toList();
}

class DustLog {
  int total;
  List<Dribblet> userAssetDribblets;

  DustLog.fromMap(Map m)
      : total = m['total'],
        userAssetDribblets = (m['userAssetDribblets'] as List<dynamic>)
            .map((e) => Dribblet.fromMap(e))
            .toList();
}

class DustConversion {
  double totalServiceCharge;
  double totalTransfered;
  List<DribbletDetail> transferResult;

  DustConversion.fromMap(Map m)
      : totalServiceCharge = double.parse(m['totalServiceCharge']),
        totalTransfered = double.parse(m['totalTransfered']),
        transferResult = (m['transferResult'] as List<dynamic>)
            .map((e) => DribbletDetail.fromMap(e))
            .toList();
}

class Dividend {
  double amount;
  String asset;
  int divTime;
  String enInfo;
  int tranId;

  Dividend.fromMap(Map m)
      : amount = double.parse(m['amount']),
        asset = m['asset'],
        divTime = m['divTime'],
        enInfo = m['enInfo'],
        tranId = m['tranId'];
}

class DividendRecord {
  List<Dividend> rows;
  int total;

  DividendRecord.fromMap(Map m)
      : rows = (m['rows'] as List<dynamic>)
            .map((e) => Dividend.fromMap(e))
            .toList(),
        total = m['total'];
}

class AssetDetail {
  String name;
  double minWithdrawAmount;
  bool depositStatus;
  int withdrawFee;
  bool withdrawStatus;
  String depositTip;

  AssetDetail.fromMapEntry(MapEntry e)
      : name = e.key,
        minWithdrawAmount = double.parse(e.value['minWithdrawAmount']),
        depositStatus = e.value['depositStatus'],
        withdrawFee = e.value['withdrawFee'],
        withdrawStatus = e.value['withdrawStatus'],
        depositTip = e.value['depositTip'];
}

class TradeFee {
  String symbol;
  double makerCommission;
  double takerCommission;

  TradeFee.fromMap(Map m)
      : symbol = m['symbol'],
        makerCommission = double.parse(m['makerCommission']),
        takerCommission = double.parse(m['takerCommission']);
}

class UniversalTransfer {
  String asset;
  double amount;
  String type;
  String status;
  int tranId;
  int timestamp;

  UniversalTransfer.fromMap(Map m)
      : asset = m['asset'],
        amount = double.parse(m['amount']),
        type = m['type'],
        status = m['status'],
        tranId = m['tranId'],
        timestamp = m['timestamp'];
}

class UniversalTransferHistory {
  int total;
  List<UniversalTransfer> rows;

  UniversalTransferHistory.fromMap(Map m)
      : total = m['total'],
        rows = (m['rows'] as List<dynamic>)
            .map((e) => UniversalTransfer.fromMap(e))
            .toList();
}

class FundingAsset {
  String asset;
  double free;
  double locked;
  double freeze;
  double withdrawing;
  double btcValuation;

  FundingAsset.fromMap(Map m)
      : asset = m['asset'],
        free = double.parse(m['free']),
        locked = double.parse(m['locked']),
        freeze = double.parse(m['freeze']),
        withdrawing = double.parse(m['withdrawing']),
        btcValuation = double.parse(m['btcValuation']);
}

class ApiRestrictions {
  bool ipRestrict;
  int createTime;
  bool enableWithdrawals;
  bool enableInternalTransfer;
  bool permitsUniversalTransfer;
  bool enableVanillaOptions;
  bool enableReading;
  bool enableFutures;
  bool enableMargin;
  bool enableSpotAndMarginTrading;
  int tradingAuthorityExpirationTime;

  ApiRestrictions.fromMap(Map m)
      : ipRestrict = m['ipRestrict'],
        createTime = m['createTime'],
        enableWithdrawals = m['enableWithdrawals'],
        enableInternalTransfer = m['enableInternalTransfer'],
        permitsUniversalTransfer = m['permitsUniversalTransfer'],
        enableVanillaOptions = m['enableVanillaOptions'],
        enableReading = m['enableReading'],
        enableFutures = m['enableFutures'],
        enableMargin = m['enableMargin'],
        enableSpotAndMarginTrading = m['enableSpotAndMarginTrading'],
        tradingAuthorityExpirationTime = m['tradingAuthorityExpirationTime'];
}
