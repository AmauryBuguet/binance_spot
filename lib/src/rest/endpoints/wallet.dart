import 'package:either_dart/either.dart';

import '../classes.dart';
import '../enums.dart';

import '../../binance_spot_api.dart';

/// Wallet endpoints for Binance Spot API
extension WalletEndpoints on BinanceSpot {
  /// Fetch system status.
  Future<Either<String, SystemStatus>> systemStatus() {
    return sendRequest(
      path: 'sapi/v1/system/status',
      type: RequestType.GET,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(SystemStatus.fromMap(r.right)));
  }

  /// Get information of coins (available for deposit and withdraw) for user.
  Future<Either<String, List<CoinData>>> allCoinsInformation({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/capital/config/getall',
      type: RequestType.GET,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
      params: params,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<CoinData>.from(r.right.map((e) => CoinData.fromMap(e)))));
  }

  /// Get daily account snapshots taken every day at 23:59:59
  ///
  /// Type must be "SPOT", "MARGIN" or "FUTURES"
  /// The query time period must be less then 30 days
  Future<Either<String, dynamic>> dailyAccountSnapshot({
    required String type,
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'type': type,
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/accountSnapshot',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) {
      if (r.isLeft) {
        return Left(r.left);
      } else {
        if (type == "SPOT") {
          return Right(Snapshots.fromMap(r.right));
        } else if (type == "MARGIN") {
          return Right(SnapshotsMargin.fromMap(r.right));
        } else if (type == "FUTURES") {
          return Right(SnapshotsMargin.fromMap(r.right));
        } else {
          return const Left("Wrong type input");
        }
      }
    });
  }

  /// This request will disable fastwithdraw switch under your account.
  ///
  /// You need to enable "trade" option for the api key which requests this endpoint.
  Future<Either<String, bool>> disableFastWithdrawSwitch({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/account/disableFastWithdrawSwitch',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }

  /// This request will enable fastwithdraw switch under your account.
  ///
  /// You need to enable "trade" option for the api key which requests this endpoint.
  /// When Fast Withdraw Switch is on, transferring funds to a Binance account will be done instantly.
  /// There is no on-chain transaction, no transaction ID and no withdrawal fee.
  Future<Either<String, bool>> enableFastWithdrawSwitch({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/account/enableFastWithdrawSwitch',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }

  /// Submit a withdraw request.
  ///
  /// If network not send, return with default network of the coin.
  Future<Either<String, String>> withdraw({
    required String coin,
    String? withdrawOrderId,
    String? network,
    required String address,
    String? addressTag,
    required String amount,
    bool? transactionFeeFlag,
    String? name,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'coin': coin,
      'address': address,
      'amount': amount,
    };
    if (withdrawOrderId != null) params['withdrawOrderId'] = withdrawOrderId;
    if (network != null) params['network'] = network;
    if (addressTag != null) params['addressTag'] = addressTag;
    if (transactionFeeFlag != null)
      params['transactionFeeFlag'] = transactionFeeFlag.toString();
    if (name != null) params['name'] = name;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/capital/withdraw/apply',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['id']));
  }

  /// Fetch deposit history.
  Future<Either<String, List<Deposit>>> depositHistory({
    required String coin,
    int? status,
    int? startTime,
    int? endTime,
    int? offset,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'coin': coin,
    };
    if (status != null) params['status'] = status.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (offset != null) params['offset'] = offset.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/capital/deposit/hisrec',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Deposit>.from(r.right.map((e) => Deposit.fromMap(e)))));
  }

  /// Fetch withdraw history.
  Future<Either<String, List<Withdraw>>> withdrawHistory({
    required String coin,
    String? withdrawOrderId,
    int? status,
    int? offset,
    int? limit,
    int? startTime,
    int? endTime,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'coin': coin,
    };
    if (withdrawOrderId != null) params['withdrawOrderId'] = withdrawOrderId;
    if (status != null) params['status'] = status.toString();
    if (offset != null) params['offset'] = offset.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/capital/withdraw/history',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<Withdraw>.from(r.right.map((e) => Withdraw.fromMap(e)))));
  }

  /// Fetch deposit address with network.
  Future<Either<String, DepositAddress>> depositAddress({
    required String coin,
    String? network,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'coin': coin,
    };
    if (network != null) params['network'] = network;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/capital/deposit/address',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) =>
        r.isLeft ? Left(r.left) : Right(DepositAddress.fromMap(r.right)));
  }

  /// Fetch account status detail.
  Future<Either<String, String>> accountStatus({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/account/status',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['data']));
  }

  /// Fetch account api trading status detail.
  Future<Either<String, AccountApiTradingData>> accountAPITradingStatus({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/account/apiTradingStatus',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(AccountApiTradingData.fromMap(r.right["data"])));
  }

  /// Crypto dust conversion to BNB history
  Future<Either<String, DustLog>> dustLog({
    int? startTime,
    int? endTime,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/dribblet',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(DustLog.fromMap(r.right)));
  }

  /// Convert dust assets to BNB.
  Future<Either<String, DustConversion>> dustTransfer({
    required List<String> assets,
    int? recvWindow,
  }) {
    if (assets.isEmpty)
      return Future.delayed(const Duration(milliseconds: 1))
          .then((value) => const Left("Empty asset array"));
    String asset = "asset=${assets.first}";
    if (assets.length > 1) {
      for (int i = 1; i < assets.length; ++i) {
        asset += "&asset=${asset[i]}";
      }
    }
    Map<String, String> params = {
      'asset': asset,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/dust',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) =>
        r.isLeft ? Left(r.left) : Right(DustConversion.fromMap(r.right)));
  }

  /// Query asset dividend record.
  Future<Either<String, DividendRecord>> assetDividendRecord({
    String? asset,
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (asset != null) params['asset'] = asset;
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/assetDividend',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) =>
        r.isLeft ? Left(r.left) : Right(DividendRecord.fromMap(r.right)));
  }

  /// Fetch details of assets supported on Binance.
  Future<Either<String, List<AssetDetail>>> assetDetail({
    String? asset,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (asset != null) params['asset'] = asset;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/assetDetail',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<AssetDetail>.from(
            (r.right as Map).entries.map((e) => AssetDetail.fromMapEntry(e)))));
  }

  /// Fetch trade fee for an asset
  Future<Either<String, List<TradeFee>>> tradeFee({
    String? symbol,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (symbol != null) params['symbol'] = symbol;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/tradeFee',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<TradeFee>.from(r.right.map((e) => TradeFee.fromMap(e)))));
  }

  /// You need to enable Permits Universal Transfer option for the api key which requests this endpoint.
  Future<Either<String, int>> universalTransfer({
    required String type,
    required String asset,
    required String amount,
    String? fromSymbol,
    String? toSymbol,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'type': type,
      'asset': asset,
      'amount': amount,
    };
    if (fromSymbol != null) params['fromSymbol'] = fromSymbol;
    if (toSymbol != null) params['toSymbol'] = toSymbol;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/transfer',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['tranId']));
  }

  /// Query User Universal Transfer History
  Future<Either<String, UniversalTransferHistory>>
      queryUniversalTransferHistory({
    required String type,
    int? startTime,
    int? endTime,
    int? current,
    int? size,
    String? fromSymbol,
    String? toSymbol,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'type': type,
    };
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (current != null) params['current'] = current.toString();
    if (size != null) params['size'] = size.toString();
    if (fromSymbol != null) params['fromSymbol'] = fromSymbol;
    if (toSymbol != null) params['toSymbol'] = toSymbol;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/transfer',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(UniversalTransferHistory.fromMap(r.right)));
  }

  /// Currently supports querying the following business assets：Binance Pay, Binance Card, Binance Gift Card, Stock Token
  Future<Either<String, List<FundingAsset>>> fundingWallet({
    String? asset,
    bool? needBtcValuation,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (asset != null) params['asset'] = asset;
    if (needBtcValuation != null)
      params['needBtcValuation'] = needBtcValuation.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/asset/get-funding-asset',
      type: RequestType.POST,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft
        ? Left(r.left)
        : Right(List<FundingAsset>.from(
            r.right.map((e) => FundingAsset.fromMap(e)))));
  }

  /// Get API Key Permissions
  Future<Either<String, ApiRestrictions>> apiKeyPermission({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/account/apiRestrictions',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) =>
        r.isLeft ? Left(r.left) : Right(ApiRestrictions.fromMap(r.right)));
  }
}
