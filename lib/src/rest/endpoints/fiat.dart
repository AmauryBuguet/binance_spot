import 'package:either_dart/either.dart';

import '../classes.dart';
import '../enums.dart';

import '../../binance_spot_api.dart';

/// Fiat endpoints for Binance Spot API
extension FiatEndpoints on BinanceSpot {
  /// Get fiat deposit and withdrawal history
  Future<Either<String, FiatTransferHistory>> getFiatDepositWithdrawHistory({
    required String transactionType,
    int? beginTime,
    int? endTime,
    int? page,
    int? rows,
  }) {
    Map<String, String> params = {
      'transactionType': transactionType,
    };
    if (beginTime != null) params['beginTime'] = beginTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (page != null) params['page'] = page.toString();
    if (rows != null) params['rows'] = rows.toString();
    return sendRequest(
      path: 'sapi/v1/fiat/orders',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(FiatTransferHistory.fromMap(r.right)));
  }

  /// Get fiat payments history
  Future<Either<String, FiatPaymentHistory>> getFiatPaymentsHistory({
    required String transactionType,
    int? beginTime,
    int? endTime,
    int? page,
    int? rows,
  }) {
    Map<String, String> params = {
      'transactionType': transactionType,
    };
    if (beginTime != null) params['beginTime'] = beginTime.toString();
    if (endTime != null) params['endTime'] = endTime.toString();
    if (page != null) params['page'] = page.toString();
    if (rows != null) params['rows'] = rows.toString();
    return sendRequest(
      path: 'sapi/v1/fiat/payments',
      type: RequestType.GET,
      params: params,
      keyRequired: true,
      signatureRequired: true,
      timestampRequired: true,
    ).then((r) => r.isLeft ? Left(r.left) : Right(FiatPaymentHistory.fromMap(r.right)));
  }
}
