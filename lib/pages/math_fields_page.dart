import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../entities/math_field/state/math_field_list_state.dart';
import '../entities/math_field/ui/math_field_list.dart';

class MathFieldsPage extends StatelessWidget {
  const MathFieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MathFieldListCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MathFieldList(),
      ),
    );
  }
}
