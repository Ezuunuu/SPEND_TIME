import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:spend_time/application.dart';
import 'package:spend_time/config/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  Paint.enableDithering = true;

  runApp(
      const Application()
  );
}