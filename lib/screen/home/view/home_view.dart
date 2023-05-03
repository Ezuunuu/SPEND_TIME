import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/screen.dart';
import 'package:spend_time/widgets/widgets.dart';

class HomeView extends AbstractScreen {
  HomeView({super.key});

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final layout = Layout(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<Widget> items = [
          CustomNavigationBarItem(
              size: 58.0 * layout.widthPercent,
              title: const Text('리스트',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                    fontSize: 10.0,
                  ),
                  textAlign: TextAlign.center),
              selectedColorBegin: const Color(0xFF3F8FEA),
              selectedColorEnd: const Color(0xFF086DFD),
              selectedIcon: SvgPicture.asset('assets/images/list_selected_icon.svg'),
              unselectedIcon: SvgPicture.asset('assets/images/list_unselected_icon.svg'),
              isSelected: state.index == 0 ? true : false,
              onClicked: () async => await context.read<HomeCubit>().changeIndex(index: 0)
          ),
          CustomNavigationBarItem(
              size: 58.0 * layout.widthPercent,
              title: const Text('나의기록',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                    fontSize: 10.0,
                  ),
                  textAlign: TextAlign.center),
              selectedColorBegin: const Color(0xFF3F8FEA),
              selectedColorEnd: const Color(0xFF086DFD),
              selectedIcon: SvgPicture.asset('assets/images/my_report_selected_icon.svg'),
              unselectedIcon: SvgPicture.asset('assets/images/my_report_unselected_icon.svg'),
              isSelected: state.index == 1 ? true : false,
              onClicked: () async => await context.read<HomeCubit>().changeIndex(index: 1)
          ),
          CustomNavigationBarItem(
              size: 58.0 * layout.widthPercent,
              title: const Text('스톱워치',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                    fontSize: 10.0,
                  ),
                  textAlign: TextAlign.center),
              selectedColorBegin: const Color(0xFF3F8FEA),
              selectedColorEnd: const Color(0xFF086DFD),
              selectedIcon: SvgPicture.asset('assets/images/stopwatch_selected_icon.svg'),
              unselectedIcon: SvgPicture.asset('assets/images/stopwatch_unselected_icon.svg'),
              isSelected: state.index == 2 ? true : false,
              onClicked: () async => await context.read<HomeCubit>().changeIndex(index: 2)
          ),
          CustomNavigationBarItem(
              size: 58.0 * layout.widthPercent,
              title: const Text('기록계산',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                    fontSize: 10.0,
                  ),
                  textAlign: TextAlign.center),
              selectedColorBegin: const Color(0xFF3F8FEA),
              selectedColorEnd: const Color(0xFF086DFD),
              selectedIcon: SvgPicture.asset('assets/images/calculator_selected_icon.svg'),
              unselectedIcon: SvgPicture.asset('assets/images/calculator_unselected_icon.svg'),
              isSelected: state.index == 3 ? true : false,
              onClicked: () async => await context.read<HomeCubit>().changeIndex(index: 3)
          ),
          CustomNavigationBarItem(
              size: 58.0 * layout.widthPercent,
              title: const Text('설정',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                    fontSize: 10.0,
                  ),
                  textAlign: TextAlign.center),
              selectedColorBegin: const Color(0xFF3F8FEA),
              selectedColorEnd: const Color(0xFF086DFD),
              selectedIcon: SvgPicture.asset('assets/images/setting_selected_icon.svg',),
              unselectedIcon: SvgPicture.asset('assets/images/setting_unselected_icon.svg',),
              isSelected: state.index == 4 ? true : false,
              onClicked: () async => await context.read<HomeCubit>().changeIndex(index: 4)
        ),
      ];

        if(context.read<SettingCubit>().state.setting?.opening ?? true) {
          context.read<SettingCubit>().disableOpening();
          Future.delayed(Duration.zero, () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomDialog(
                    width: 280.0 * layout.widthPercent,
                    height: 214.0 * layout.heightPercent,
                    backgroundColor: const Color(0xFFFFFFFF),
                    title: const Material(
                      child: Text('습관부터 만들어볼까요?',
                        style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    content: Material(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('리스트에서 습관을 추가하면\n더욱 간편하게 이용할 수 있어요!',
                            style: TextStyle(
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                                fontSize: 14.0,
                                height: 1.25
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text('습관 추가 없이도 바로 사용 가능해요',
                            style: TextStyle(
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1775E5),
                                fontSize: 14.0,
                                height: 1.25
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    button: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 124.0 * layout.widthPercent,
                          height: 36.0 * layout.heightPercent,
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(const Color(0xFF000000))
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: const Text('일단 둘러볼래', style: TextStyle(
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 14.0,
                                  height: 1.25
                              ),
                                textAlign: TextAlign.start,)
                          ),
                        ),
                        SizedBox(
                          width: 124.0 * layout.widthPercent,
                          height: 36.0 * layout.heightPercent,
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(const Color(0xFF3F8FEA))
                              ),
                              onPressed: () async {
                                await context.read<HomeCubit>().changeIndex(index: 0);
                                if(context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('추가할래', style: TextStyle(
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 14.0,
                                  height: 1.25
                              ),
                                textAlign: TextAlign.start,)
                          ),
                        ),
                      ],
                    ),
                  );
                });
          });
        }

        return Scaffold(
          backgroundColor: const Color(0xFFEEF0F6),
          bottomNavigationBar: CustomNavigationBar(
            items: items,
            backgroundColor: const Color(0xFFF4F7FF),
            height: 43.0 * layout.heightPercent,
          ),
          body: SafeArea(
            child: CarouselSlider(
              carouselController: _carouselController,
              items: const [HabitListView(), RecordListView(), StopwatchView(), CalculateView(), SettingView()],
              options: CarouselOptions(
                  height: layout.fullHeight,
                  initialPage: 2,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  onPageChanged: (int index, _) async {
                    await context.read<HomeCubit>().changeIndex(index: index);
                  }),
            ),
          ),
        );
      },
    );
  }
}