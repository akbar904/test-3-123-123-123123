
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animal_switcher/models/animal_model.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should correctly initialize with name and icon', () {
			final animal = Animal('Cat', Icons.pets);
			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});

		test('Animal model should support different animal types', () {
			final cat = Animal('Cat', Icons.pets);
			final dog = Animal('Dog', Icons.person);

			expect(cat.name, 'Cat');
			expect(cat.icon, Icons.pets);

			expect(dog.name, 'Dog');
			expect(dog.icon, Icons.person);
		});
	});
}
