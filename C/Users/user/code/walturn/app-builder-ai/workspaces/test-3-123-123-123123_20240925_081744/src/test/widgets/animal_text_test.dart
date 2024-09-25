
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/widgets/animal_text.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalText Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('Displays initial animal state (Cat)', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal('Cat', Icons.pets));

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AnimalCubit>.value(
							value: animalCubit,
							child: AnimalText(),
						),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.pets), findsOneWidget);
		});

		testWidgets('Displays switched animal state (Dog)', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal('Dog', Icons.person));

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AnimalCubit>.value(
							value: animalCubit,
							child: AnimalText(),
						),
					),
				),
			);

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('Tap on text switches animal state', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal('Cat', Icons.pets));
			when(() => animalCubit.switchAnimal()).thenAnswer((_) async {});

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AnimalCubit>.value(
							value: animalCubit,
							child: AnimalText(),
						),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			verify(() => animalCubit.switchAnimal()).called(1);
		});
	});
}
