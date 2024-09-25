
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:animal_switcher/screens/home_screen.dart';

// Mock Cubit for testing
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon by default', (tester) async {
			// Arrange
			when(() => animalCubit.state).thenReturn(Animal('Cat', Icons.access_time));

			// Act
			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon when state is switched', (tester) async {
			// Arrange
			whenListen(
				animalCubit,
				Stream.fromIterable([Animal('Cat', Icons.access_time), Animal('Dog', Icons.person)]),
				initialState: Animal('Cat', Icons.access_time),
			);

			// Act
			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: HomeScreen(),
					),
				),
			);
			await tester.pump(); // Rebuild with new state

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('tapping on animal text switches the animal', (tester) async {
			// Arrange
			when(() => animalCubit.state).thenReturn(Animal('Cat', Icons.access_time));
			when(() => animalCubit.switchAnimal()).thenAnswer((_) async {});

			// Act
			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: HomeScreen(),
					),
				),
			);
			await tester.tap(find.text('Cat'));
			await tester.pump();

			// Assert
			verify(() => animalCubit.switchAnimal()).called(1);
		});
	});
}
