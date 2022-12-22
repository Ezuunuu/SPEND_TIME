import 'package:flutter/material.dart';
import 'package:spend_time/config/config.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d("Calculator view");
    return const Center(child: Text('Calculator view'));
  }
}
