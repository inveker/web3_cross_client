import 'package:web3_cross_client/client_strategies/types.dart';

abstract class ClientStrategy {
  Future<ConnectionResult> connect(ConnectionReadyCallback readyConnection);
}

