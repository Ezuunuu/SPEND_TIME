import 'package:flutter/material.dart';
///-
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/widgets/widgets.dart';
import 'package:spend_time/screen/home/home.dart';
import 'package:spend_time/animation/animation.dart';
import 'package:spend_time/screen/setting/setting.dart';
import 'package:spend_time/screen/opening/opening.dart';

class WalkThroughView extends StatefulWidget {
  const WalkThroughView({Key? key}) : super(key: key);

  @override
  State<WalkThroughView> createState() => _WalkThroughViewState();
}

class _WalkThroughViewState extends State<WalkThroughView> with TickerProviderStateMixin {
  int currentIndex = 0;

  final CarouselController _controller = CarouselController();

  late AnimationController _backAnimationController;
  late Animation<double> _backAnimation;

  late AnimationController _dotAnimationController;
  late Animation<double> _dotAnimation;

  late AnimationController _btnAnimationController;
  late Animation<double> _btnAnimation;

  @override
  void initState() {
    super.initState();
    _backAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _backAnimation = CurvedAnimation(
      parent: _backAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    _dotAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _dotAnimation = CurvedAnimation(
      parent: _dotAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    _btnAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _btnAnimation = CurvedAnimation(
      parent: _btnAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = CustomLayoutInfo(MediaQuery.of(context));

    final List<Widget> screenList = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 52.0 * layout.heightPercent,
          ),
          const Text(
            "할일 시작 하기 전에\n스톱워치 부터",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w800,
              color: Color(0xFF000000),
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.0 * layout.heightPercent,
          ),
          const Text(
            "습관을 시간으로 기록해요",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w500,
              color: Color(0xFF496D97),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10.0 * layout.heightPercent,
          ),
          Lottie.asset('assets/lottie/walk_through_1_lottie.json', width: 152.0 * layout.widthPercent, fit: BoxFit.fill, repeat: true),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 52.0 * layout.heightPercent,
          ),
          const Text(
            "일이 끝나면\n정지 버튼을 탭",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w800,
              color: Color(0xFF000000),
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.0 * layout.heightPercent,
          ),
          const Text(
            "정지 버튼을 눌러서 시간을 기록하세요",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w500,
              color: Color(0xFF496D97),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10.0 * layout.heightPercent,
          ),
          Lottie.asset('assets/lottie/walk_through_2_lottie.json', width: 152.0 * layout.widthPercent, fit: BoxFit.fill, repeat: true),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 52.0 * layout.heightPercent,
          ),
          const Text(
            "나의 기록에서\n시간을 확인",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w800,
              color: Color(0xFF000000),
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.0 * layout.heightPercent,
          ),
          const Text(
            "나의 기록 페이지에서 사용한 시간을 볼 수 있어요",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w500,
              color: Color(0xFF496D97),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10.0 * layout.heightPercent,
          ),
          Lottie.asset('assets/lottie/walk_through_3_lottie.json', width: 152.0 * layout.widthPercent, fit: BoxFit.fill, repeat: true),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 52.0 * layout.heightPercent,
          ),
          const Text(
            "초 모드와 분 모드\n두가지 선택지가 있어요",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w800,
              color: Color(0xFF000000),
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.0 * layout.heightPercent,
          ),
          const Text(
            "😄 걱정마세요. 나중에 다시 설정할 수 있어요.",
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w500,
              color: Color(0xFF496D97),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 39.0 * layout.heightPercent,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      child: const Text(
                        '분 모드',
                        style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
                      child: const Text(
                        '08 : 30',
                        style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                          fontSize: 22,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0 * layout.heightPercent,
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
                      decoration: BoxDecoration(color: const Color(0xFF3F8FEA), borderRadius: BorderRadius.circular(4.0)),
                      child: const Text(
                        '초 모드',
                        style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
                      child: const Text(
                        '08 : 30 : 00',
                        style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                          fontSize: 22,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 39.0 * layout.heightPercent,
              ),
            ],
          ),
        ],
      ),
    ];

    logger.d("WalkThrough View");

    if (currentIndex == 0 || currentIndex == 3) {
      _backAnimationController.forward();
    } else {
      _backAnimationController.reverse();
    }

    if (currentIndex == 3) {
      _dotAnimationController.reverse();
    } else {
      _dotAnimationController.forward();
    }

    if (currentIndex == 3) {
      _btnAnimationController.forward();
    } else {
      _btnAnimationController.reverse();
    }

    return Scaffold(
      appBar: CustomAppBar(
        leftButton: FadeTransition(
          opacity: _backAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
            child: Transform.scale(
              scale: 0.8,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Image.asset('assets/images/back_btn.png'),
                onPressed: () => Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const OpeningView()).slideRightToLeft(), (route) => false),
              ),
            ),
          ),
        ),
        rightButton: FadeTransition(
          opacity: _dotAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 * layout.widthPercent),
            child: ButtonTheme(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: TextButton(
                onPressed: () async {
                  await context.read<HomeCubit>().setTutorial(true);
                  await context.read<SettingCubit>().switchVisibleOpening();
                  await context.read<SettingCubit>().switchSecMinMode(SecMinMode.second);
                  Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const HomeView()).fadeIn(), (route) => false);
                },
                child: const Text(
                  "뛰어넘기",
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA8B8CA),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEEF0F6),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
                carouselController: _controller,
                items: screenList,
                options: CarouselOptions(
                    viewportFraction: 1.0,
                    initialPage: 0,
                    height: 350.0 * layout.heightPercent,
                    enableInfiniteScroll: false,
                    onPageChanged: (int index, _) {
                      setState(() {
                        currentIndex = index;
                      });
                    })),
            Stack(
              children: [
                Opacity(
                  opacity: currentIndex != 3 ? 1.0 : 0.0,
                  child: CarouselDot(size: 8.0 * layout.widthPercent, count: screenList.length, index: currentIndex, selectedColor: const Color(0xFF3F8FEA), unselectedColor: const Color(0xFFCFE4FD)),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10.0 * layout.heightPercent,
                    ),
                    FadeTransition(
                      opacity: _btnAnimation,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56.0 * layout.heightPercent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF76B5F4))),
                              onPressed: () async {
                                if(currentIndex == 3) {
                                  await context.read<HomeCubit>().setTutorial(true);
                                  await context.read<SettingCubit>().switchVisibleOpening();
                                  await context.read<SettingCubit>().switchSecMinMode(SecMinMode.minute);
                                  Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const HomeView()).fadeIn(), (route) => false);
                                }
                              },
                              child: const Text(
                                '분까지 계산할래',
                                style: TextStyle(
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16.0 * layout.heightPercent,
            ),
            Stack(
              children: [
                FadeTransition(
                  opacity: _dotAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.0 * layout.heightPercent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5))),
                          onPressed: () async {
                            if(currentIndex != 3) {
                              _controller.nextPage();
                            }else {
                              await context.read<HomeCubit>().setTutorial(true);
                              Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const HomeView()).fadeIn(), (route) => false);
                            }
                          },
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
                ),
                FadeTransition(
                  opacity: _btnAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.0 * layout.heightPercent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0 * layout.widthPercent),
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5))),
                          onPressed: () async {
                            if(currentIndex != 3) {
                              _controller.nextPage();
                            }else {
                              await context.read<HomeCubit>().setTutorial(true);
                              await context.read<SettingCubit>().switchVisibleOpening();
                              await context.read<SettingCubit>().switchSecMinMode(SecMinMode.second);
                              Navigator.pushAndRemoveUntil(context, AnimatedPageMove(const HomeView()).fadeIn(), (route) => false);
                            }
                          },
                          child: const Text(
                            '초까지 계산할래',
                            style: TextStyle(
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0 * layout.heightPercent,
            ),
          ],
        ),
      ),
    );
  }
}
