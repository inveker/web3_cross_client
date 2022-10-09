import 'package:web3_cross_client/client_strategies/client_strategy.dart';
import 'package:web3_cross_client/client_strategies/types.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

class Web3DartContext {
  Web3Client? _web3client;

  RpcService? _rpc;

  CredentialsWithKnownAddress? _credentials;

  ClientStrategy? _clientStrategy;

  Web3DartContext({
    ClientStrategy? clientStrategy,
  }) : _clientStrategy = clientStrategy;

  Web3Client get web3client => _web3client ?? (throw Exception('Web3Client not initialized'));

  RpcService get rpc => _rpc ?? (throw Exception('RpcService not initialized'));

  CredentialsWithKnownAddress get credentials => _credentials ?? (throw Exception('Credentials not initialized'));

  void setClientStrategy(ClientStrategy clientStrategy) {
    _clientStrategy = clientStrategy;
  }

  void connect(ConnectionReadyCallback connectionReady) async {
    if (_clientStrategy == null) throw Exception('ClientStrategy not settlement');
    final connectionResult = await _clientStrategy!.connect(connectionReady);
    _web3client = connectionResult.web3client;
    _rpc = connectionResult.rpcService;
    _credentials = connectionResult.credentials;
  }
}
