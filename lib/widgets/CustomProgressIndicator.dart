import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomProgressIndicator extends ConsumerWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 5.0,
        ),
      ],
    );
  }
}
