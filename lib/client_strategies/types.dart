import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

typedef ConnectionReadyCallback = void Function(String? connectUri);

class ConnectionResult {
  final Web3Client web3client;
  final RpcService rpcService;
  final CredentialsWithKnownAddress credentials;

  ConnectionResult({
    required this.web3client,
    required this.rpcService,
    required this.credentials,
  });
}
