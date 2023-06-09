import 'package:either_dart/either.dart';

import '../classes.dart';
import '../enums.dart';

import '../../binance_spot_api.dart';

/// Subaccount / Corporate endpoints for Binance Spot API
///
/// Note that email address should be encoded while sending API calls.
/// e.g. alice@test.com should be encoded into alice%40test.com x
extension SubaccountEndpoints on BinanceSpot {
  /// This request will generate a virtual sub account under your master account.
  ///
  /// You need to enable "trade" option for the api key which requests this endpoint.
  Future<Either<String, String>> createVirtualSubaccount({
    required String subAccountString,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'subAccountString': subAccountString,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/virtualSubAccount',
      type: RequestType.postRequest,
      params: params,
      timestampRequired: true,
      keyRequired: true,
      signatureRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['email']));
  }

  /// Get list of all subaccounts
  Future<Either<String, SubaccountList>> querySubaccountList({
    String? email,
    bool? isFreeze,
    int? page,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (email != null) params['email'] = email;
    if (isFreeze != null) params['isFreeze'] = isFreeze.toString();
    if (page != null) params['page'] = page.toString().toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/list',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(SubaccountList.fromMap(r.right)));
  }

  /// Get spot assets transfer history for all subaccounts
  Future<Either<String, List<SubaccountTransfer>>> querySubaccountSpotAssetTransferHistory({
    String? fromEmail,
    String? toEmail,
    int? startTime,
    int? endTime,
    int? page,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (fromEmail != null) params['fromEmail'] = fromEmail;
    if (toEmail != null) params['toEmail'] = toEmail;
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/sub/transfer/history',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(List<SubaccountTransfer>.from(r.right.map((e) => SubaccountTransfer.fromMap(e)))));
  }

  /// Get futures assets transfer history for all subaccounts
  Future<Either<String, SubaccountFuturesTransferHistory>> querySubaccountFuturesAssetTransferHistory({
    required String email,
    String? futuresType,
    int? startTime,
    int? endTime,
    int? page,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (futuresType != null) params['futuresType'] = futuresType;
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/futures/internalTransfer',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(SubaccountFuturesTransferHistory.fromMap(r.right)));
  }

  /// Request a futures asset transfer to a subaccount
  Future<Either<String, SubaccountFuturesTransfer>> subaccountFuturesAssetTransfer({
    required String fromEmail,
    required String toEmail,
    required int futuresType,
    required String asset,
    required String amount,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'fromEmail': fromEmail,
      'toEmail': toEmail,
      'futuresType': futuresType.toString(),
      'asset': asset,
      'amount': amount,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/futures/internalTransfer',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(SubaccountFuturesTransfer.fromMap(r.right)));
  }

  /// Get list of assets on a subaccount
  Future<Either<String, SubaccountBalances>> querySubaccountAssets({
    required String email,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v3/sub-account/assets',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(SubaccountBalances.fromMap(r.right)));
  }

  /// Get BTC valued asset summary of subaccouts.
  Future<Either<String, SubaccountSpotAssetsSummary>> querySubaccountSpotAssetsSummary({
    String? email,
    int? page,
    int? size,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (email != null) params['email'] = email;
    if (page != null) params['page'] = page.toString();
    if (size != null) params['size'] = size.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/spotSummary',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(SubaccountSpotAssetsSummary.fromMap(r.right)));
  }

  /// Get Sub-account spot Deposit Address (For Master Account)
  Future<Either<String, DepositAddress>> getDepositAddress({
    required String email,
    required String coin,
    String? network,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
      'coin': coin,
    };
    if (network != null) params['network'] = network;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/capital/deposit/subAddress',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(DepositAddress.fromMap(r.right)));
  }

  /// Fetch Sub-account Deposit History (For Master Account)
  Future<Either<String, List<Deposit>>> getSubaccountDepositHistory({
    required String email,
    String? coin,
    int? status,
    int? startTime,
    int? endTime,
    int? limit,
    int? offset,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (coin != null) params['coin'] = coin;
    if (status != null) params['status'] = status.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (offset != null) params['offset'] = offset.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/capital/deposit/subHisrec',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(List<Deposit>.from(r.right.map((e) => Deposit.fromMap(e)))));
  }

  /// Get Sub-account's Status on Margin/Futures (For Master Account)
  Future<Either<String, List<SubaccountStatus>>> getSubaccountsStatusonMarginFutures({
    String? email,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (email != null) params['email'] = email;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/status',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(List<SubaccountStatus>.from(r.right.map((e) => SubaccountStatus.fromMap(e)))));
  }

  /// Enable Margin for Sub-account (For Master Account)
  Future<Either<String, bool>> enableMarginforSubaccount({
    required String email,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/margin/enable',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right["isMarginEnabled"]));
  }

  /// Get Detail on Sub-account's Margin Account (For Master Account)
  Future<Either<String, SubaccountMarginDetail>> getSubaccountMarginDetail({
    required String email,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/margin/account',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(SubaccountMarginDetail.fromMap(r.right)));
  }

  /// Get Summary of Sub-account's Margin Account (For Master Account)
  Future<Either<String, AllSubaccountMarginSummary>> getSubaccountsMarginSummary({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/margin/accountSummary',
      type: RequestType.getRequest,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : Right(AllSubaccountMarginSummary.fromMap(r.right)));
  }

  /// Enable Margin for Sub-account (For Master Account)
  Future<Either<String, bool>> enableFuturesforSubaccount({
    required String email,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/futures/enable',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right["isFuturesEnabled"]));
  }

  /// Get Detail on Sub-account's Futures Account (For Master Account)
  Future<Either<String, SubaccountFuturesDetail>> getSubaccountFuturesDetail({
    required String email,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/futures/account',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(SubaccountFuturesDetail.fromMap(r.right)));
  }

  /// Get Summary of Sub-account's Futures Account (For Master Account)
  Future<Either<String, AllSubaccountFuturesSummary>> getSubaccountsFuturesSummary({
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/futures/accountSummary',
      type: RequestType.getRequest,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : Right(AllSubaccountFuturesSummary.fromMap(r.right)));
  }

  /// Get Futures Position-Risk of Sub-account (For Master Account)
  Future<Either<String, List<SubaccountFuturesPositionRisk>>> getSubaccountFuturesPostionRisk({
    required String email,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/futures/positionRisk',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) =>
        r.isLeft ? Left(r.left) : Right(List<SubaccountFuturesPositionRisk>.from(r.right.map((e) => SubaccountFuturesPositionRisk.fromMap(e)))));
  }

  /// Futures Transfer for Sub-account (For Master Account)
  Future<Either<String, int>> subaccountFuturesTransfer({
    required String email,
    required String asset,
    required String amount,
    required int type,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
      'asset': asset,
      'amount': amount,
      'type': type.toString(),
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/futures/transfer',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['txnId']));
  }

  /// Transfer to Sub-account of Same Master (For Sub-account)
  Future<Either<String, int>> transfertoSubaccountofSameMaster({
    required String toEmail,
    required String asset,
    required String amount,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'toEmail': toEmail,
      'asset': asset,
      'amount': amount,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/transfer/subToSub',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['txnId']));
  }

  /// Transfer to Master (For Sub-account)
  Future<Either<String, int>> transferToMaster({
    required String asset,
    required String amount,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'asset': asset,
      'amount': amount,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/transfer/subToMaster',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['txnId']));
  }

  /// Sub-account Transfer History (For Sub-account)
  Future<Either<String, List<SubaccountTransferData>>> subaccountTransferHistory({
    String? asset,
    int? type,
    int? startTime,
    int? endTime,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (asset != null) params['asset'] = asset;
    if (type != null) params['type'] = type.toString();
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/transfer/subUserHistory',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(List<SubaccountTransferData>.from(r.right.map((e) => SubaccountTransferData.fromMap(e)))));
  }

  /// Universal Transfer (For Master Account)
  ///
  /// You need to enable "internal transfer" option for the api key which requests this endpoint.
  /// Transfer from master account by default if fromEmail is not sent.
  /// Transfer to master account by default if toEmail is not sent.
  /// Transfer between futures accounts is not supported.
  Future<Either<String, int>> subaccountUniversalTransfer({
    String? fromEmail,
    String? toEmail,
    required String fromAccountType,
    required String toAccountType,
    required String asset,
    required String amount,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'fromAccountType': fromAccountType,
      'toAccountType': toAccountType,
      'asset': asset,
      'amount': amount,
    };
    if (fromEmail != null) params['fromEmail'] = fromEmail;
    if (toEmail != null) params['toEmail'] = toEmail;
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/universalTransfer',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['tranId']));
  }

  /// Query Universal Transfer History (For Master Account)
  ///
  /// fromEmail and toEmail cannot be sent at the same time.
  /// Return fromEmail equal master account email by default.
  /// Only get the latest history of past 30 days.
  Future<Either<String, List<SubaccountUniversalTransfer>>> subaccountsQueryUniversalTransferHistory({
    String? fromEmail,
    String? toEmail,
    int? startTime,
    int? endTime,
    int? page,
    int? limit,
    int? recvWindow,
  }) {
    Map<String, String> params = {};
    if (fromEmail != null) params['fromEmail'] = fromEmail;
    if (toEmail != null) params['toEmail'] = toEmail;
    if (startTime != null) params['startTime'] = startTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/universalTransfer',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then(
        (r) => r.isLeft ? Left(r.left) : Right(List<SubaccountUniversalTransfer>.from(r.right.map((e) => SubaccountUniversalTransfer.fromMap(e)))));
  }

  /// Enable Leverage Token for Sub-account (For Master Account)
  Future<Either<String, bool>> subaccountEnableLeverageToken({
    required String email,
    required bool enableBlvt,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
      'enableBlvt': enableBlvt.toString(),
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/sub-account/blvt/enable',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['enableBlvt']));
  }

  /// Deposit assets into the managed sub-account (For Investor Master Account)
  Future<Either<String, int>> depositAssetInSubaccount({
    required String toEmail,
    required String asset,
    required String amount,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'toEmail': toEmail,
      'asset': asset,
      'amount': amount,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/managed-subaccount/deposit',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['tranId']));
  }

  /// Query managed sub-account asset details（For Investor Master Account）
  Future<Either<String, List<ManagedSubaccountAsset>>> queryManagedSubaccountAssets({
    required String email,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'email': email,
    };
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/managed-subaccount/asset',
      type: RequestType.getRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(List<ManagedSubaccountAsset>.from(r.right.map((e) => ManagedSubaccountAsset.fromMap(e)))));
  }

  /// Withdraw assets from the managed sub-account（For Investor Master Account）
  Future<Either<String, int>> withdrawAssetsFromManagedSubaccount({
    required String fromEmail,
    required String asset,
    required String amount,
    int? transferDate,
    int? recvWindow,
  }) {
    Map<String, String> params = {
      'fromEmail': fromEmail,
      'asset': asset,
      'amount': amount,
    };
    if (transferDate != null) params['transferDate'] = transferDate.toString();
    if (recvWindow != null) params['recvWindow'] = recvWindow.toString();
    return sendRequest(
      path: 'sapi/v1/managed-subaccount/withdraw',
      type: RequestType.postRequest,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(r.right['tranId']));
  }
}
