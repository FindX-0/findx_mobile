import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../entities/math_field/state/math_field_list_state.dart';
import '../entities/math_field/ui/math_field_list.dart';
import '../entities/user_meta/ui/user_trophy_chip.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MathFieldListCubit>()),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 16, 16, 4),
            child: UserTrophyChip(),
          ),
        ),
        Expanded(child: MathFieldList()),
      ],
    );
  }
}
