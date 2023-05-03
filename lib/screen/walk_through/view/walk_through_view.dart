import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/database/database.dart';
import 'package:spend_time/screen/screen.dart';
import 'package:spend_time/widgets/widgets.dart';

class WalkThroughView extends AbstractScreen {
  const WalkThroughView({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Layout(context);
    final CarouselController controller = CarouselController();

    final List<Widget> screenList = [
      WalkThroughModel(
          headline: 'walk_through_headline_1',
          sub: 'walk_through_sub_1',
          lottie: 'assets/lottie/walk_through_1_lottie.json',
          layout: layout
      ),
      WalkThroughModel(
          headline: 'walk_through_headline_2',
          sub: 'walk_through_sub_2',
          lottie: 'assets/lottie/walk_through_2_lottie.json',
          layout: layout
      ),
      WalkThroughModel(
          headline: 'walk_through_headline_3',
          sub: 'walk_through_sub_3',
          lottie: 'assets/lottie/walk_through_3_lottie.json',
          layout: layout
      ),
      WalkThroughModel(
          headline: 'walk_through_headline_4',
          sub: 'walk_through_sub_4',
          layout: layout
      ),
    ];

    return BlocBuilder<WalkThroughCubit, WalkThroughState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              leftButton: AnimatedOpacity(
                opacity: state.index == 3 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
                  child: Transform.scale(
                    scale: 0.8,
                    child: IconButton(
                      icon: Image.asset('assets/images/back_btn.png'),
                      onPressed: () => state.index == 3 ? Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const OpeningView()).slideRightToLeft(), (route) => false) : null,
                    ),
                  ),
                ),
              ),
              rightButton: AnimatedOpacity(
                opacity: state.index != 3 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
                  child: TextButton(
                    onPressed: () => state.index != 3 ? controller.jumpToPage(3) : null,
                    child: Text("skip", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: const Color(0xFFABB8CA))).tr(),
                  ),
                ),
              )
            ),
            backgroundColor: const Color(0xFFEEF0F6),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                    carouselController: controller,
                    items: screenList,
                    options: CarouselOptions(
                        viewportFraction: 1.0,
                        initialPage: 0,
                        height: 354.0 * layout.heightPercent,
                        enableInfiniteScroll: false,
                        onPageChanged: (int index, _) async {
                          await context.read<WalkThroughCubit>().setIndex(index);
                        }
                    )
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56.0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.fastOutSlowIn,
                    switchOutCurve: Curves.fastOutSlowIn,
                    child: state.index != 3 ? Padding(
                      padding: EdgeInsets.only(bottom: 24.0 * layout.heightPercent),
                      child: CarouselDot(key: const Key('dot'), size: 8.0 * layout.widthPercent, count: screenList.length, index: state.index, selectedColor: const Color(0xFF3F8FEA), unselectedColor: const Color(0xFFCFE4FD)),
                    ) : Padding(
                      key: const Key('btn'),
                      padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF76B5F4)), minimumSize: MaterialStateProperty.all(const Size.fromHeight(50))),
                          /// TODO: 홈으로 가기
                          onPressed: () async {
                            await context.read<SettingCubit>().setMode(TimeMode.minute);
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(context, AnimatedPageMove(HomeView()).slideRightToLeft(), (route) => false);
                            }
                          },
                          child: Text('walk_through_btn_minute', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFFFFFFF))).tr()),
                    ),
                  ),
                ),
                SizedBox(height: 16.0 * layout.heightPercent),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.fastOutSlowIn,
                  switchOutCurve: Curves.fastLinearToSlowEaseIn,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5))),
                        /// TODO: 홈으로 가기
                        onPressed: () async {
                          if(state.index != 3) {
                            controller.nextPage();
                          }else {
                            await context.read<SettingCubit>().setMode(TimeMode.second);
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(context, AnimatedPageMove(HomeView()).slideRightToLeft(), (route) => false);
                            }
                          }
                        },
                        child: state.index != 3 ? Text(key: const Key('next'),'next', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFFFFFFF))).tr() : Text(key: const Key('walk_through_btn_second'), 'walk_through_btn_second', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFFFFFFF))).tr(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80.0 * layout.heightPercent),
              ],
            )
          );
      }
    );
  }
}