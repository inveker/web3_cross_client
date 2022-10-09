import 'package:web3_cross_client/src/client_strategies/client_strategy.dart';
import 'package:web3_cross_client/src/client_strategies/types.dart';
import 'package:web3_ethereum/web3_ethereum.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart_ethereum/web3dart_ethereum.dart';

class Web3EthereumClientStrategy extends ClientStrategy {
  static bool isSupported() => Web3Ethereum.isSupported;

  @override
  Future<ConnectionResult> connect(ConnectionReadyCallback readyConnection) async {
    readyConnection(null);
    final web3ethereum = _buildWeb3Ethereum();
    final rpcService = _buildRpcService(web3ethereum);
    final web3client = _buildWeb3Client(rpcService);
    final credentials = await _buildCredentials(web3ethereum);

    return ConnectionResult(
      web3client: web3client,
      rpcService: rpcService,
      credentials: credentials,
    );
  }

  Web3Ethereum _buildWeb3Ethereum() {
    return Web3Ethereum();
  }

  RpcService _buildRpcService(Web3Ethereum web3ethereum) {
    return Web3EthereumRpc(web3ethereum);
  }

  Web3Client _buildWeb3Client(RpcService rpcService) {
    return Web3Client.custom(rpcService);
  }

  Future<CredentialsWithKnownAddress> _buildCredentials(Web3Ethereum web3ethereum) async {
    final accounts = await web3ethereum.connect();
    return Web3EthereumCredentials(
      web3ethereum,
      addressHex: accounts.first,
    );
  }
}