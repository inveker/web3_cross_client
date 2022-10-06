import 'dart:async';

import 'package:web3_cross_client/web3_cross_client.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart_walletconnect/web3dart_walletconnect.dart';

class WalletConnectClient extends Web3CrossClient {
  @override
  final RpcService rpc;

  @override
  final Web3Client web3client;

  @override
  CredentialsWithKnownAddress? credentials;

  final WalletConnect _walletConnect;

  WalletConnectClient._(
    this._walletConnect, {
    required this.web3client,
    required this.rpc,
  });

  factory WalletConnectClient() {
    final walletConnect = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: ['https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'],
      ),
    );
    final walletConnectRpc = WalletConnectRpc(walletConnect);
    final walletConnectClient = Web3Client.custom(walletConnectRpc);

    return WalletConnectClient._(
      walletConnect,
      web3client: walletConnectClient,
      rpc: walletConnectRpc,
    );
  }

  @override
  Future<void> connect(void Function(String? connectUri) readyConnection) async {
    final completer = Completer<List<String>>();
    _walletConnect.on(
      'connect',
      (SessionStatus session) => completer.complete(session.accounts),
    );
    await _walletConnect.createSession(
      onDisplayUri: readyConnection,
    );
    final accounts = await completer.future;
    credentials = WalletConnectCredentials(
      EthereumWalletConnectProvider(_walletConnect),
      addressHex: accounts.first,
    );
  }
}
