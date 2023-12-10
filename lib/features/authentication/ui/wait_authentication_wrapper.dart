import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/device_sign_in_state.dart';

class WaitAuthenticationWrapper extends StatelessWidget {
  const WaitAuthenticationWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceSignInCubit, DeviceSignInState>(
      builder: (_, state) {
        return state.maybeWhen(
          executed: () => child,
          executing: () => const Center(child: CircularProgressIndicator()),
          failed: (f) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failred, $f'),
                const SizedBox(height: 42),
                TextButton(
                  onPressed: context.deviceSignInCubit.onRetryPressed,
                  child: const Text('Retry'),
                )
              ],
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
