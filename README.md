# Description

Cross client by web3dart. Implement connection to browser extensions and walletconnect

# Installation

```yaml
dependencies:
    web3_cross_client:
        git: https://github.com/inveker/web3_cross_client
```


# Usage


## Walletconnect

```dart
final type = Web3CrossSupportedClients.walletconnect;
final web3crossClient = Web3CrossClient.fromType(type);
await web3crossClient.connect((connectUri) {
  //Use deeplink or qr code with connectUri to connect
  print('Wallet connection uri $connectUri');
});
final credentials = web3crossClient.credentials;
```

## Metamask chrome

```dart
final type = Web3CrossSupportedClients.web3ethereum;
final web3crossClient = Web3CrossClient.fromType(type);
await web3crossClient.connect((connectUri) {});
final credentials = web3crossClient.credentials;
```