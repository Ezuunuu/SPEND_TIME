import 'package:flutter/material.dart';

abstract class AbstractScreen extends StatelessWidget {
  const AbstractScreen({Key? key}) : super(key: key);

  Route route(BuildContext context) => MaterialPageRoute<void>(builder: (_) => this);
}