import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
      ),
    );
  }
}
