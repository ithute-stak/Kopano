import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kopano/main.dart';

void main() {
  testWidgets('Kopano home and navigation render', (tester) async {
    await tester.pumpWidget(const KopanoApp());
    expect(find.text('Kopano'), findsOneWidget);
    expect(find.text('Meet • Connect • Explore'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('Discover').last);
    await tester.pumpAndSettle();
    expect(find.text('Recommended for you'), findsOneWidget);

    await tester.tap(find.text('Matches').last);
    await tester.pumpAndSettle();
    expect(find.text('Your matches will appear here'), findsOneWidget);
  });

  testWidgets('Home opens dedicated dating screen', (tester) async {
    await tester.pumpWidget(const KopanoApp());
    await tester.tap(find.text('Dating'));
    await tester.pumpAndSettle();
    expect(find.text('Discover meaningful connections'), findsOneWidget);
  });

  testWidgets('Home opens places preview', (tester) async {
    await tester.pumpWidget(const KopanoApp());
    await tester.tap(find.text('Places'));
    await tester.pumpAndSettle();
    expect(find.text('Explore around Lesotho'), findsOneWidget);
  });
}
