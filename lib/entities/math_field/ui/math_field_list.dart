import 'package:findx_dart_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/values/assets.dart';
import '../state/math_field_list_state.dart';

class MathFieldList extends StatelessWidget {
  const MathFieldList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MathFieldListCubit, MathFieldListState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) => _Entry(mathField: data[index]),
            padding: const EdgeInsets.all(16),
          ),
        );
      },
    );
  }
}

class _Entry extends StatelessWidget {
  const _Entry({
    required this.mathField,
  });

  final GetAllMathFieldsItem mathField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 2,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Assets.imageEinstein,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned.fill(
                child: ColoredBox(color: Colors.black26),
              ),
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.3, 1],
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          mathField.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Play'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
