import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Color polkadotPink = const Color(0xFFFF2670);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PBA Stateful Multisig',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Unbounded',
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
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: polkadotPink,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: polkadotPink,
              disabledForegroundColor: Colors.white.withOpacity(0.3),
              disabledBackgroundColor: Colors.grey,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: polkadotPink,
            ),
          ),
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: polkadotPink,
            titleTextStyle: const TextStyle(color: Colors.white),
          ),
        ),
        home: Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.all(20),
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFDCE2E9), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 25),
                    SizedBox(
                      height: 25,
                      child: Image.asset(
                        'assets/images/Polkadot_Logo_Pink-Black.png',
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(width: 2, height: 50, color: Color(0xFFDCE2E9)),
                    SizedBox(width: 20),
                    Text(
                      'PBA Luzern\nStateful Multisig Challange',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        )
    );
  }
}