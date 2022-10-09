import 'dart:async';

import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3_cross_client/client_strategies/client_strategy.dart';
import 'package:web3_cross_client/client_strategies/types.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart_walletconnect/web3dart_walletconnect.dart';

class WalletConnectClientStrategy extends ClientStrategy {
  @override
  Future<ConnectionResult> connect(ConnectionReadyCallback readyConnection) async {
    final walletConnect = _buildWalletConnect();
    final rpcService = _buildRpcService(walletConnect);
    final web3client = _buildWeb3Client(rpcService);
    final credentials = await _buildCredentials(walletConnect, readyConnection);

    return ConnectionResult(
      web3client: web3client,
      rpcService: rpcService,
      credentials: credentials,
    );
  }

  WalletConnect _buildWalletConnect() {
    return WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: ['https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'],
      ),
    );
  }

  RpcService _buildRpcService(WalletConnect walletConnect) {
    return WalletConnectRpc(walletConnect);
  }

  Web3Client _buildWeb3Client(RpcService rpcService) {
    return Web3Client.custom(rpcService);
  }

  Future<CredentialsWithKnownAddress> _buildCredentials(WalletConnect walletConnect, ConnectionReadyCallback readyConnection) async{
    final completer = Completer<List<String>>();
    walletConnect.on(
      'connect',
          (SessionStatus session) => completer.complete(session.accounts),
    );
    await walletConnect.createSession(
      onDisplayUri: readyConnection,
    );
    final accounts = await completer.future;
    return WalletConnectCredentials(
      EthereumWalletConnectProvider(walletConnect),
      addressHex: accounts.first,
    );
  }
}
