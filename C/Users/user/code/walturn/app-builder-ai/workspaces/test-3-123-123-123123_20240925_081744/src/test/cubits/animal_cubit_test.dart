
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/models/animal_model.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalCubit Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is Cat', () {
			expect(animalCubit.state.name, 'Cat');
			expect(animalCubit.state.icon, Icons.access_time);
		});

		blocTest<AnimalCubit, Animal>(
			'emits Dog when switchAnimal is called',
			build: () => animalCubit,
			act: (cubit) => cubit.switchAnimal(),
			expect: () => [
				Animal(name: 'Dog', icon: Icons.person),
			],
		);

		blocTest<AnimalCubit, Animal>(
			'emits Cat when switchAnimal is called twice',
			build: () => animalCubit,
			act: (cubit) {
				cubit.switchAnimal();
				cubit.switchAnimal();
			},
			expect: () => [
				Animal(name: 'Dog', icon: Icons.person),
				Animal(name: 'Cat', icon: Icons.access_time),
			],
		);
	});
}
