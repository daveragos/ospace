class Crypto {
  final String name;
  final String symbol;
  final String image;
  final double currentPrice;
  final double marketCap;
  final double marketCapRank;
  final double totalVolume;
  final double priceChangePercentage24h;
  final double high24h;
  final double low24h;

  Crypto({
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.totalVolume,
    required this.priceChangePercentage24h,
    required this.high24h,
    required this.low24h,
  });

  // Factory constructor to create a Crypto object from a JSON map
  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      image: json['image'] as String,
      currentPrice: (json['current_price'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(),
      marketCapRank: (json['market_cap_rank'] as num).toDouble(),
      totalVolume: (json['total_volume'] as num).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] as num).toDouble(),
      high24h: (json['high_24h'] as num).toDouble(),
      low24h: (json['low_24h'] as num).toDouble(),
    );
  }

  // Method to convert Crypto object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'total_volume': totalVolume,
      'price_change_percentage_24h': priceChangePercentage24h,
      'high_24h': high24h,
      'low_24h': low24h,
    };
  }
}
