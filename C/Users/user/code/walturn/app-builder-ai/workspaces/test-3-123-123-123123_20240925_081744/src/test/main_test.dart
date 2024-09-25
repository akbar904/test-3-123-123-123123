
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:animal_switcher/main.dart';

void main() {
	group('Main App Initialization', () {
		testWidgets('App starts and shows HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			// Verify that the HomeScreen is displayed
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});
}
