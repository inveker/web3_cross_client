import 'package:web3_cross_client/src/client_strategies/client_strategy.dart';
import 'package:web3_cross_client/src/client_strategies/types.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

class Web3DartContext {
  Web3Client? _web3client;

  RpcService? _rpc;

  CredentialsWithKnownAddress? _credentials;

  ClientStrategy? _clientStrategy;

  Web3DartContext({
    Web3Client? web3client,
    RpcService? rpc,
    CredentialsWithKnownAddress? credentials,
    ClientStrategy? clientStrategy,
  }) {
    _web3client = web3client;
    _rpc = rpc;
    _credentials = credentials;
    _web3client = web3client;
    _clientStrategy = clientStrategy;
  }

  Web3Client get web3client => _web3client ?? (throw Exception('Web3Client not initialized'));

  RpcService get rpc => _rpc ?? (throw Exception('RpcService not initialized'));

  CredentialsWithKnownAddress get credentials => _credentials ?? (throw Exception('Credentials not initialized'));

  Future<void> reset() async {
    await _web3client?.dispose();
    _web3client = null;
    _rpc = null;
    _credentials = null;
    await _clientStrategy?.quit();
    _clientStrategy = null;
  }

  void setClientStrategy(ClientStrategy clientStrategy) {
    reset();
    _clientStrategy = clientStrategy;
  }

  void connect(ConnectionReadyCallback connectionReady) async {
    if (_clientStrategy == null) throw Exception('ClientStrategy not settlement');
    final connectionResult = await _clientStrategy!.connect(connectionReady);
    _web3client = connectionResult.web3client;
    _rpc = connectionResult.rpcService;
    _credentials = connectionResult.credentials;
  }

  bool isConnected() {
    bool isWeb3ClientInitialized = _web3client != null;
    bool isRpcInitialized = _rpc != null;
    bool isCredentialsInitialized = _credentials != null;
    return isWeb3ClientInitialized && isRpcInitialized && isCredentialsInitialized;
  }
}
