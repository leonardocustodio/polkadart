import 'package:flutter/material.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

class PolkadotApp extends StatefulWidget {
  const PolkadotApp({super.key});

  @override
  State<PolkadotApp> createState() => _PolkadotAppState();
}

class _PolkadotAppState extends State<PolkadotApp> {
  final keyring = Keyring();
  List<Account> accounts = [];

  generateNewAccount() async {
    final derivationPath =
        '//Alice${accounts.isNotEmpty ? '//${accounts.length}' : ''}';

    final wallet = await keyring.fromUri(derivationPath, addToPairs: true);
    final account = Account(wallet.address, derivationPath);

    setState(() {
      accounts.add(account);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFFF2670, <int, Color>{
          50: polkadotPink,
          100: polkadotPink,
          200: polkadotPink,
          300: polkadotPink,
          400: polkadotPink,
          500: polkadotPink,
          600: polkadotPink,
          700: polkadotPink,
          800: polkadotPink,
          900: polkadotPink,
        }),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: polkadotPink,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 3),
              child: Text('Generate wallets by clicking on the button'),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        minTileHeight: 10,
                        enabled: true,
                        title: Text(
                          accounts[index].encodedAddress,
                          style: const TextStyle(fontSize: 13),
                        ),
                        subtitle: Text(
                          accounts[index].derivationPath,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ElevatedButton(
                onPressed: () async => await generateNewAccount(),
                child: const Text('Generate a new account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Account {
  final String encodedAddress;
  final String derivationPath;

  Account(this.encodedAddress, this.derivationPath);
}

Color polkadotPink = const Color(0xFFFF2670);

void main() {
  runApp(const PolkadotApp());
}
