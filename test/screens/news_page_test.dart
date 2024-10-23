// import 'package:any_link_preview/any_link_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ospace/screens/news_page.dart';
// import 'package:ospace/service/api_helper.dart';
// import 'package:mockito/mockito.dart';
// import 'package:ospace/widgets/shimmer_card_widget.dart';
// import 'package:shimmer/shimmer.dart';

// // Mock class for ApiHelper
// class MockApiHelper extends Mock implements ApiHelper {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   group('NewsPage Tests', () {
//     late MockApiHelper mockApiHelper;

//     setUp(() {
//       mockApiHelper = MockApiHelper();
//     });

//     testWidgets('initial loading shows shimmer effect', (WidgetTester tester) async {
//       // Arrange
//       when(mockApiHelper.fetchNewsStoryIds()).thenAnswer((_) async => []);
//       when(mockApiHelper.loadNewsArticlesByIds(any)).thenAnswer((_) async => []);

//       // Act
//       await tester.pumpWidget(MaterialApp(home: NewsPage()));
//       await tester.pumpAndSettle();

//       // Assert
//       expect(find.byType(ShimmerNewsCard), findsNWidgets(10)); // Assuming 10 shimmer cards show up
//     });

//     testWidgets('loading more news articles', (WidgetTester tester) async {
//       // Arrange
//       when(mockApiHelper.fetchNewsStoryIds()).thenAnswer((_) async => List.generate(30, (index) => index));
//       when(mockApiHelper.loadNewsArticlesByIds(any)).thenAnswer((_) async => List.generate(30, (index) => 'Link $index'));

//       // Act
//       await tester.pumpWidget(MaterialApp(home: NewsPage()));
//       await tester.pumpAndSettle();
//       await tester.tap(find.byType(GestureDetector)); // Tap to load more
//       await tester.pumpAndSettle();

//       // Assert
//       expect(find.byType(AnyLinkPreview), findsWidgets); // Check if news items are displayed
//     });

//     testWidgets('shows loading indicator when loading more articles', (WidgetTester tester) async {
//       // Arrange
//       when(mockApiHelper.fetchNewsStoryIds()).thenAnswer((_) async => List.generate(30, (index) => index));
//       when(mockApiHelper.loadNewsArticlesByIds(any<List<int>>())).thenAnswer((_) async {
//         await Future.delayed(Duration(seconds: 2));
//         return List.generate(30, (index) => 'Link $index');
//       });

//       // Act
//       await tester.pumpWidget(MaterialApp(home: NewsPage()));
//       await tester.pumpAndSettle();
//       await tester.tap(find.byType(GestureDetector)); // Tap to load more
//       await tester.pump(); // Start loading
//       expect(find.byType(Shimmer), findsOneWidget); // Check for shimmer effect during loading
//       await tester.pumpAndSettle(); // Finish loading

//       // Assert
//       expect(find.byType(AnyLinkPreview), findsWidgets); // Check if news items are displayed after loading
//     });

//     // Add more tests as necessary
//   });
// }
