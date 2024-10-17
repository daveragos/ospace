import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    SizedBox(width: 20),
                    Text('C R Y P T O', style: TextStyle(fontSize: 20)),
                    Row(
                      children: [
                        Text('BTC', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text('12°C', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(children: [
                    Text('26°C', style: TextStyle(fontSize: 86)),
                    Text('light rain', style: TextStyle(fontSize: 16)),
                  ]),
                  SizedBox(
                    width: 148,
                    height: 148,
                    child: PhosphorIcon(PhosphorIcons.currencyBtc(),
                        size: 148),
                  ),
                ]),

                SizedBox(height: 20),
                Column(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('ETHERIUM'),
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                              width: 36.0,
                              child: PhosphorIcon(PhosphorIcons.currencyEth(),
                                  size: 36),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$2346.23',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                     Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('ETHERIUM'),
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                              width: 36.0,
                              child: PhosphorIcon(PhosphorIcons.currencyEth(),
                                  size: 36),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$2346.23',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('ETHERIUM'),
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                              width: 36.0,
                              child: PhosphorIcon(PhosphorIcons.currencyEth(),
                                  size: 36),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$2346.23',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('ETHERIUM'),
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                              width: 36.0,
                              child: PhosphorIcon(PhosphorIcons.currencyEth(),
                                  size: 36),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$2346.23',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('ETHERIUM'),
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                              width: 36.0,
                              child: PhosphorIcon(PhosphorIcons.currencyEth(),
                                  size: 36),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$2346.23',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text('ETHERIUM'),
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                              width: 36.0,
                              child: PhosphorIcon(PhosphorIcons.currencyCircleDollar(),
                                  size: 36),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$2346.23',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
