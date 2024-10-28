import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ospace/service/api_helper.dart';
import 'package:ospace/screens/crypto_page.dart';

class MockApiHelper extends Mock implements ApiHelper {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CryptoPage Tests', () {
    late MockApiHelper mockApiHelper;

    setUp(() {
      mockApiHelper = MockApiHelper();
    });

    testWidgets('shows loading indicator initially', (WidgetTester tester) async {
      // Arrange
      when(mockApiHelper.fetchCryptoPrices()).thenAnswer((_) async => []);

      // Act
      await tester.pumpWidget(MaterialApp(home: CryptoPage()));
      await tester.pump(); // Allow the loading state to show

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays crypto data after loading', (WidgetTester tester) async {
      // Arrange
      final cryptoList = [
  {
    "name": "Bitcoin",
    "symbol": "btc",
    "image": "https://example.com/bitcoin.png",
    "current_price": 60000.0,
    "market_cap": 1000000000.0,
    "market_cap_rank": 1,
    "total_volume": 50000000.0,
    "price_change_percentage_24h": 2.5,
    "high_24h": 61000.0,
    "low_24h": 59000.0,
  },
  // Add more mock cryptocurrencies as needed
];


      when(mockApiHelper.fetchCryptoPrices()).thenAnswer((_) async => cryptoList);

      // Act
      await tester.pumpWidget(MaterialApp(home: CryptoPage()));
      await tester.pumpAndSettle(); // Wait for data to load

      // Assert
      expect(find.text('Bitcoin'), findsOneWidget);
      expect(find.text('\$60000.00'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('selects a cryptocurrency and displays its details', (WidgetTester tester) async {
      // Arrange
      final cryptoList = [
        {
          "id": "bitcoin",
          "symbol": "btc",
          "name": "Bitcoin",
          "current_price": 60000.0,
          "market_cap": 1000000000.0,
          "total_volume": 50000000.0,
          "high_24h": 61000.0,
          "low_24h": 59000.0,
          "image": "https://example.com/bitcoin.png",
          "price_change_percentage_24h": 2.5,
          "market_cap_rank": 1,
        },
        {
          "id": "ethereum",
          "symbol": "eth",
          "name": "Ethereum",
          "current_price": 4000.0,
          "market_cap": 500000000.0,
          "total_volume": 30000000.0,
          "high_24h": 4100.0,
          "low_24h": 3900.0,
          "image": "https://example.com/ethereum.png",
          "price_change_percentage_24h": 1.5,
          "market_cap_rank": 2,
        },
      ];

      when(mockApiHelper.fetchCryptoPrices()).thenAnswer((_) async => cryptoList);

      // Act
      await tester.pumpWidget(MaterialApp(home: CryptoPage()));
      await tester.pumpAndSettle(); // Wait for data to load

      // Tap on Ethereum
      await tester.tap(find.text('Ethereum'));
      await tester.pump(); // Rebuild the widget

      // Assert
      expect(find.text('Ethereum'), findsOneWidget);
      expect(find.text('\$4000.00'), findsOneWidget);
      expect(find.text('Rank: 2'), findsOneWidget);
    });
  });
}
