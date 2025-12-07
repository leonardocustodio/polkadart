import 'package:polkadart/polkadart.dart' show SystemApi, ChainType, Health, PeerInfo, SyncState;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import './mock_provider.dart' show MockProvider;

void main() {
  group('SystemApi', () {
    test('name', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback('system_name', (params, state) => 'Parity Polkadot');
      expect(api.name(), completion('Parity Polkadot'));
    });

    test('version', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback('system_version', (params, state) => '0.9.43-ba42b9ce51d');
      expect(api.version(), completion('0.9.43-ba42b9ce51d'));
    });

    test('chain', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback('system_chain', (params, state) => 'Polkadot');
      expect(api.chain(), completion('Polkadot'));
    });

    test('chainType', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback('system_chainType', (params, state) => 'Development');
      expect(api.chainType(), completion(ChainType.values.development()));

      provider.setMethodCallback('system_chainType', (params, state) => 'Live');
      expect(api.chainType(), completion(ChainType.values.live()));

      provider.setMethodCallback('system_chainType', (params, state) => 'Local');
      expect(api.chainType(), completion(ChainType.values.local()));

      provider.setMethodCallback(
        'system_chainType',
        (params, state) => {'Custom': 'polkadart 1337'},
      );
      expect(api.chainType(), completion(ChainType.values.custom('polkadart 1337')));
    });

    test('health', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback(
        'system_health',
        (params, state) => {'peers': 22, 'isSyncing': false, 'shouldHavePeers': true},
      );
      expect(api.health(), completion(Health(peers: 22, isSyncing: false, shouldHavePeers: true)));
    });

    test('localPeerId', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback(
        'system_localPeerId',
        (params, state) => '12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
      );
      expect(api.localPeerId(), completion('12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby'));
    });

    test('localListenAddresses', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback(
        'system_localListenAddresses',
        (params, state) => [
          '/ip6/::1/tcp/34102/ws/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip6/2800:c20:0:11::66/tcp/34102/ws/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip6/fe80::4c41:2cff:fe96:5f75/tcp/34102/ws/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip4/127.0.0.1/tcp/33102/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip4/192.168.0.102/tcp/33102/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip6/::1/tcp/33102/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
        ],
      );
      expect(
        api.localListenAddresses(),
        completion([
          '/ip6/::1/tcp/34102/ws/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip6/2800:c20:0:11::66/tcp/34102/ws/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip6/fe80::4c41:2cff:fe96:5f75/tcp/34102/ws/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip4/127.0.0.1/tcp/33102/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip4/192.168.0.102/tcp/33102/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
          '/ip6/::1/tcp/33102/p2p/12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
        ]),
      );
    });

    test('peers', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback(
        'system_peers',
        (params, state) => [
          {
            'peerId': '12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
            'roles': 'Full',
            'bestHash': '0x1a162f9495422abd65e48fc4768bccfd3d19c9ad71009975738bd4c0dd5bfdb3',
            'bestNumber': 1000,
          },
        ],
      );
      expect(
        api.peers(),
        completion([
          PeerInfo(
            peerId: '12D3KooWBDg7u6dBEo82fJe4kyDJT3L2C8kYNYGNvuBkEPVryKby',
            roles: 'Full',
            bestHash: '0x1a162f9495422abd65e48fc4768bccfd3d19c9ad71009975738bd4c0dd5bfdb3',
            bestNumber: 1000,
          ),
        ]),
      );
    });

    test('accountNextIndex', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback('system_accountNextIndex', (params, state) {
        assert(params.length == 1);
        assert(params[0] == '15kUt2i86LHRWCkE3D9Bg1HZAoc2smhn1fwPzDERTb1BXAkX');
        return 258938;
      });
      expect(
        api.accountNextIndex('15kUt2i86LHRWCkE3D9Bg1HZAoc2smhn1fwPzDERTb1BXAkX'),
        completion(258938),
      );
    });

    test('syncState', () {
      final provider = MockProvider(null);
      final api = SystemApi(provider);
      provider.setMethodCallback(
        'system_syncState',
        (params, state) => {
          'startingBlock': 16299243,
          'currentBlock': 16313588,
          'highestBlock': 16313589,
        },
      );
      expect(
        api.syncState(),
        completion(
          SyncState(startingBlock: 16299243, currentBlock: 16313588, highestBlock: 16313589),
        ),
      );
    });
  });
}
