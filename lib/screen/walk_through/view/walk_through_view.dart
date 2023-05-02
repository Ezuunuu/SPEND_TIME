import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/screen.dart';
import 'package:spend_time/widgets/widgets.dart';

class WalkThroughView extends AbstractScreen {
  const WalkThroughView({super.key});



  @override
  Widget build(BuildContext context) {
    final layout = Layout(MediaQuery.of(context));
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
          lottie: 'assets/lottie/walk_through_1_lottie.json',
          layout: layout
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        leftButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
          child: Transform.scale(
            scale: 0.8,
            child: IconButton(
              icon: Image.asset('assets/images/back_btn.png'),
              onPressed: () => Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const OpeningView()).slideRightToLeft(), (route) => false),
            ),
          ),
        ),
        rightButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
          child: TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const WalkThroughView()), (route) => false),
            child: const Text(
              "skip",
              style: TextStyle(
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w500,
                color: Color(0xFFA8B8CA),
                fontSize: 16,
              ),
            ).tr(),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEEF0F6),
      body: SafeArea(
        child: BlocBuilder<WalkThroughCubit, WalkThroughState>(
          builder: (context, state) {
            return Column(
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
                        })),
                CarouselDot(size: 8.0 * layout.widthPercent, count: screenList.length, index: state.index, selectedColor: const Color(0xFF3F8FEA), unselectedColor: const Color(0xFFCFE4FD)),
                SizedBox(
                  height: 40.0 * layout.heightPercent,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5))),

                        /// TODO: 홈으로 가기
                        onPressed: () => state.index != 2 ? controller.nextPage() : Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const OpeningView()).slideRightToLeft(), (route) => false),
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFFFFFF),
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 80.0 * layout.heightPercent,
                ),
              ],
            );
          }
        ),
      ),
    );
  }

}