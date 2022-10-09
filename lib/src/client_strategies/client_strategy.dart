import 'package:web3_cross_client/src/client_strategies/types.dart';

abstract class ClientStrategy {
  Future<ConnectionResult> connect(ConnectionReadyCallback readyConnection);

  Future<void> quit() async {}
}
