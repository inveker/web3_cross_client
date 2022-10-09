import 'package:web3_cross_client/src/client_strategies/client_strategy.dart';

abstract class Web3EthereumClientStrategy extends ClientStrategy {
  static bool isSupported() => false;
}