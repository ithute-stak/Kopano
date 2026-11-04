import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kopano/main.dart';
import 'package:kopano/feature_screens.dart';
import 'package:kopano/premium_screens.dart';
import 'package:kopano/settings_screens.dart';
import 'package:kopano/sign_in_screen.dart';
import 'package:kopano/auth_contract.dart';
import 'package:kopano/ui_components.dart';

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
  testWidgets('Demo chat keeps messages locally', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ChatPreviewScreen()));
    expect(find.text('Local demonstration: messages are not sent or saved.'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Hello Kopano');
    await tester.tap(find.byTooltip('Add demo message'));
    await tester.pump();
    expect(find.text('Hello Kopano'), findsOneWidget);
  });

  testWidgets('Event detail routes to ticket preview', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: EventDetailPreview()));
    await tester.tap(find.text('View ticket selection'));
    await tester.pumpAndSettle();
    expect(find.byType(TicketPreviewScreen), findsOneWidget);
  });
  testWidgets('Privacy controls are explicit demo preferences', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrivacySafetyPreview()));
    expect(find.text('You control your visibility'), findsOneWidget);
    final toggle = find.byKey(const Key('dating-visibility'));
    expect(toggle, findsOneWidget);
    await tester.tap(toggle);
    await tester.pump();
    expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
  });

  testWidgets('Profile navigates to privacy settings', (tester) async {
    await tester.pumpWidget(const KopanoApp());
    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Privacy & Safety'));
    await tester.pumpAndSettle();
    expect(find.text('You control your visibility'), findsOneWidget);
  });
  testWidgets('Sign in validates locally and remains in demo mode', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
    expect(find.text('Welcome back'), findsOneWidget);
    await tester.tap(find.text('Sign in (preview)'));
    await tester.pump();
    expect(find.text('Enter a valid phone number'), findsOneWidget);
    expect(find.text('Use at least 8 characters'), findsOneWidget);
  });

  test('Disabled auth adapter never authenticates', () async {
    const gateway = DisabledAuthGateway();
    expect(await gateway.restoreSession(), isNull);
    await expectLater(
      gateway.signIn(phone: '+26650000000', password: 'not-a-real-password'),
      throwsA(isA<AuthUnavailableException>()),
    );
  });

  test('Phone validator accepts Lesotho international format', () {
    expect(KopanoFormValidation.phone('+266 5000 0000'), isNull);
    expect(KopanoFormValidation.phone('abc'), isNotNull);
  });
}
