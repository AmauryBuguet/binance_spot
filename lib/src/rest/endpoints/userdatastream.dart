import 'package:either_dart/either.dart';

import '../enums.dart';

import '../../binance_spot_api.dart';

extension SpotUserdataStreamEndpoints on BinanceSpot {
  /// Start a new user data stream end returns listenKey.
  ///
  /// The stream will close after 60 minutes unless a keepalive is sent.
  /// If the account has an active listenKey, that listenKey will be returned and its validity will be extended for 60 minutes.
  Future<Either<String, String>> createListenKey() => sendRequest(
        path: 'api/v3/userDataStream',
        type: RequestType.POST,
        keyRequired: true,
      ).then((r) => r.isRight ? Right(r.right['listenKey']) : Left(r.left));

  /// Keepalive a user data stream to prevent a time out.
  ///
  /// User data streams will close after 60 minutes.
  /// It's recommended to send a ping about every 30 minutes.
  Future<Either<String, bool>> pingListenKey({
    required String listenKey,
  }) {
    Map<String, String> params = {'listenKey': listenKey};
    return sendRequest(
      path: 'api/v3/userDataStream',
      type: RequestType.PUT,
      keyRequired: true,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }

  /// Close out a user data stream.
  Future<Either<String, bool>> deleteListenKey({
    required String listenKey,
  }) {
    Map<String, String> params = {'listenKey': listenKey};
    return sendRequest(
      path: 'api/v3/userDataStream',
      type: RequestType.DELETE,
      keyRequired: true,
      params: params,
    ).then((r) => r.isLeft ? Left(r.left) : const Right(true));
  }
}
