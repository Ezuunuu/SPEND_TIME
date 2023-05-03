import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_time/config/config.dart';

class WalkThroughModel extends StatelessWidget {
  const WalkThroughModel(
      {
        Key? key,
        required this.headline,
        required this.sub,
        this.lottie,
        required this.layout
      }) : super(key: key);

  final String headline;
  final String sub;

  final String? lottie;

  final Layout layout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(headline, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: const Color(0xFF000000)), textAlign: TextAlign.center).tr(),
        SizedBox(height: 16.0 * layout.heightPercent),
        Text(sub, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF496D97))).tr(),
        lottie != null ? Lottie.asset(lottie!, width: 226.0 * layout.widthPercent, fit: BoxFit.fill, repeat: true) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 52.0 * layout.heightPercent,
                ),
                Container(
                  width: 320.0 * layout.widthPercent,
                  height: 40.0 * layout.heightPercent,
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
                  decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(4.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 64.0 * layout.widthPercent,
                        height: 24.0 * layout.heightPercent,
                        decoration: BoxDecoration(color: const Color(0xFF76B5F4), borderRadius: BorderRadius.circular(4.0)),
                        child: Text('walk_through_minute', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFFFFFFFF)), textAlign: TextAlign.center).tr(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
                        child: Text('08 : 30', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: const Color(0xFF000000))),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.0 * layout.heightPercent),
                Container(
                  width: 320.0 * layout.widthPercent,
                  height: 40.0 * layout.heightPercent,
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
                  decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(4.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 64.0 * layout.widthPercent,
                        height: 24.0 * layout.heightPercent,
                        decoration: BoxDecoration(color: const Color(0xFF3F8FEA), borderRadius: BorderRadius.circular(4.0)),
                        child: Text('walk_through_second', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFFFFFFFF)), textAlign: TextAlign.center).tr(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
                        child: Text('08 : 30 : 00', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: const Color(0xFF000000))),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 39.0 * layout.heightPercent),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
