library web3_cross_client;

import 'package:web3_cross_client/implementations/wallet_connect_client.dart';
import 'package:web3_cross_client/implementations/web/placeholder.dart'
    if (dart.library.html) 'package:web3_cross_client/implementations/web/realization.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

enum Web3CrossSupportedClients {
  web3ethereum,
  walletConnect,
}

abstract class Web3CrossClient {
  static List<Web3CrossSupportedClients> get supportedPlatforms {
    return [
      if (web3ethereumClientIsSupported()) Web3CrossSupportedClients.web3ethereum,
      Web3CrossSupportedClients.walletConnect,
    ];
  }

  abstract final Web3Client web3client;

  abstract final RpcService rpc;

  abstract CredentialsWithKnownAddress? credentials;

  Web3CrossClient();

  factory Web3CrossClient.fromType(Web3CrossSupportedClients type) {
    switch (type) {
      case Web3CrossSupportedClients.web3ethereum:
        return Web3EthereumClient();
      case Web3CrossSupportedClients.walletConnect:
        return WalletConnectClient();
    }
  }

  Future<bool> isConnected() async {
    final response = await rpc.call('eth_accounts');
    final accounts = response.result as List<String>;
    return accounts.isNotEmpty;
  }

  Future<void> connect(void Function(String? connectUri) readyConnection);
}