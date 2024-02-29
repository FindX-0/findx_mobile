import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/matchmaking_state.dart';

class CancelMatchmakingButton extends StatelessWidget {
  const CancelMatchmakingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchmakingCubit, MatchmakingState>(
      buildWhen: (previous, current) => previous.enqueueTicketState != current.enqueueTicketState,
      builder: (_, state) {
        return state.enqueueTicketState.maybeWhen(
          orElse: () => TextButton(
            onPressed: context.matchmakingCubit.onCancelTicketPressed,
            child: const Text('Cancel'),
          ),
          executing: () => const TextButton(
            onPressed: null,
            child: Text('Cancel'),
          ),
        );
      },
    );
  }
}
