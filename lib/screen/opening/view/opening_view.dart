import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/screen.dart';
import 'package:spend_time/widgets/widgets.dart';

class OpeningView extends AbstractScreen {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Layout(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEEF0F6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/opening_lottie.json', width: 236.0 * layout.widthPercent, fit: BoxFit.fill, repeat: true),
              Text(
                "opening_headline",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: const Color(0xFF000000)),
              ).tr(),
              SizedBox(height: 16.0 * layout.heightPercent),
              Text(
                "opening_sub",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF496D97))
              ).tr(),
              SizedBox(height: 91.0 * layout.heightPercent),
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5))),
                      onPressed: () async {
                        await context.read<WalkThroughCubit>().setIndex(0);
                        if (context.mounted) {
                          Navigator.push(context, AnimatedPageMove(const WalkThroughView()).fadeIn());
                        }
                      },
                      child: Text('opening_btn', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFFFFFFF))).tr()),
                ),
              ),
              SizedBox(height: 80.0 * layout.heightPercent),
            ],
          ),
        ),
      ),
    );
  }
}