import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class MatchMathProblemImage extends StatelessWidget {
  const MatchMathProblemImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: SafeImage(
        url: null,
        placeholderColor: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class MatchMathProblemTexContainer extends StatelessWidget {
  const MatchMathProblemTexContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Tex');
  }
}

class MatchMathProblemText extends StatelessWidget {
  const MatchMathProblemText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Description of the problem');
  }
}

class MatchMathProblemAnswers extends StatelessWidget {
  const MatchMathProblemAnswers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _MathProblemAnswer(text: '3'),
        _MathProblemAnswer(text: '4'),
        _MathProblemAnswer(text: '5'),
        _MathProblemAnswer(text: '6'),
      ],
    );
  }
}

class _MathProblemAnswer extends StatelessWidget {
  const _MathProblemAnswer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.primaryContainer,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
