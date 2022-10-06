import 'package:web3_cross_client/web3_cross_client.dart';
import 'package:web3_ethereum/web3_ethereum.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart_ethereum/web3dart_ethereum.dart';

class Web3EthereumClient extends Web3CrossClient {
  @override
  final RpcService rpc;

  @override
  final Web3Client web3client;

  @override
  CredentialsWithKnownAddress? credentials;

  final Web3Ethereum _web3ethereum;

  Web3EthereumClient._(
    this._web3ethereum, {
    required this.web3client,
    required this.rpc,
  });

  factory Web3EthereumClient() {
    final web3ethereum = Web3Ethereum();
    final web3ethereumRpc = Web3EthereumRpc(web3ethereum);
    final web3EthereumClient = Web3Client.custom(web3ethereumRpc);

    return Web3EthereumClient._(
      web3ethereum,
      web3client: web3EthereumClient,
      rpc: web3ethereumRpc,
    );
  }

  @override
  Future<void> connect(void Function(String? connectUri) readyConnection) async {
    readyConnection(null);
    final accounts = await _web3ethereum.connect();
    credentials = Web3EthereumCredentials(
      _web3ethereum,
      addressHex: accounts.first,
    );
  }
}

bool web3ethereumClientIsSupported() {
  return Web3Ethereum.isSupported;
}
