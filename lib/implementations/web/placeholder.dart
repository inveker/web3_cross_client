import 'package:web3_cross_client/web3_cross_client.dart';

abstract class Web3EthereumClient extends Web3CrossClient {
  factory Web3EthereumClient() {
    throw UnimplementedError('JavaScript client is not supported on this platform');
  }
}

bool web3ethereumClientIsSupported() {
  return false;
}
