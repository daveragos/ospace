import 'package:flutter/material.dart';
import 'package:ospace/model/crypto.dart';
import 'package:ospace/service/api_helper.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final ApiHelper _cryptoService = ApiHelper();
  List<Crypto> cryptoData = [];
  Crypto? selectedCrypto; // To store the selected crypto, default BTC
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCryptoData();
  }

  String formatNumber(double number) {
    if (number >= 1e12) {
      return '${(number / 1e12).toStringAsFixed(2)}T';
    } else if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(2)}M';
    } else if (number >= 1e3) {
      return '${(number / 1e3).toStringAsFixed(2)}K';
    } else {
      return number.toStringAsFixed(2);
    }
  }

  Future<void> _fetchCryptoData() async {
    try {
      final data = await _cryptoService.fetchCryptoPrices();
      setState(() {
        cryptoData = data.map<Crypto>((json) => Crypto.fromJson(json)).toList();
        selectedCrypto =
            cryptoData.firstWhere((crypto) => crypto.symbol == 'btc');
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching crypto data: $e');
    }
  }

  // Widget to display detailed info of the selected coin
  Widget _buildSelectedCoinDetails(Crypto crypto) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade400,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              crypto.name.length > 10
                  ? Text(crypto.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                  : Text(crypto.name,
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              Text('(${crypto.symbol.toUpperCase()})',
                  style: TextStyle(fontSize: 18)),
              Text('Rank: ${crypto.marketCapRank.toInt()}',
                  style: TextStyle(fontSize: 18)),
              Text('Market Cap: \$${formatNumber(crypto.marketCap)}',
                  style: TextStyle(fontSize: 18)),
              Text('Volume: \$${formatNumber(crypto.totalVolume)}',
                  style: TextStyle(fontSize: 18)),
              Text('Daily Range:', style: TextStyle(fontSize: 18)),
              Text(
                  '\$${crypto.high24h.toStringAsFixed(2)} - \$${crypto.low24h.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
          Spacer(),
          Column(
            children: [
              SizedBox(
                  height: 140,
                  width: 140,
                  child: Image.network(crypto.image, fit: BoxFit.cover)),
              Text('\$${crypto.currentPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18)),
              Text('${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: crypto.priceChangePercentage24h >= 0
                          ? Colors.green
                          : Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    SizedBox(width: 20),
                    Text('C R Y P T O', style: TextStyle(fontSize: 20)),
                    Column(
                      children: [
                        Text(
                            '  ${formatNumber(selectedCrypto?.currentPrice ?? 0)}',
                            style: TextStyle(fontSize: 20)),
                        Text(selectedCrypto?.symbol.toUpperCase() ?? 'BTC',
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),

                // Detailed container for the selected coin
                if (selectedCrypto != null)
                  _buildSelectedCoinDetails(selectedCrypto!),

                SizedBox(height: 20),

                // Display crypto list
                isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: cryptoData.map((crypto) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCrypto = crypto;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width / 4,
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Column(
                                          children: [
                                            Text(crypto.name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                '${crypto.symbol.toUpperCase()}/USD',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 36.0,
                                      width: 36.0,
                                      child: Image.network(crypto.image,
                                          fit: BoxFit.cover),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width / 5,
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Column(
                                          children: [
                                            Text(
                                                '\$${crypto.currentPrice.toStringAsFixed(2)}',
                                                style: TextStyle(fontSize: 20)),
                                            Text(
                                                '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        crypto.priceChangePercentage24h >=
                                                                0
                                                            ? Colors.green
                                                            : Colors.red)),
                                            // Text('Volume: \$${formatNumber(crypto.totalVolume)}', style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
