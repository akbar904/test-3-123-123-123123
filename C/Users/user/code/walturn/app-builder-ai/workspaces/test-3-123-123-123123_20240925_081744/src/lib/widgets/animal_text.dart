
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/models/animal_model.dart';

class AnimalText extends StatelessWidget {
	const AnimalText({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, Animal>(
			builder: (context, animal) {
				return GestureDetector(
					onTap: () => context.read<AnimalCubit>().switchAnimal(),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(animal.name),
							SizedBox(width: 8),
							Icon(animal.icon),
						],
					),
				);
			},
		);
	}
}
