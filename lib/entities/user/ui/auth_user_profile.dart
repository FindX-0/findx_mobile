import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/auth_user_state.dart';

class AuthUserProfile extends StatelessWidget {
  const AuthUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUserCubit, AuthUserState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (data) => Text(data.userName ?? ''),
        );
      },
    );
  }
}
