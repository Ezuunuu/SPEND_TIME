import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as w;
///-
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';
import 'package:spend_time/widgets/widgets.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/screen/setting/setting.dart';

class ListCategoryView extends StatefulWidget {
  const ListCategoryView(
      {
        Key? key,
        required this.category,
        required this.layout,
        this.isSelected = false,
        required this.select
      }) : super(key: key);

  final CategoryModel category;
  final CustomLayoutInfo layout;
  final bool isSelected;
  final Function select;

  @override
  State<ListCategoryView> createState() => _ListCategoryViewState();
}

class _ListCategoryViewState extends State<ListCategoryView> with TickerProviderStateMixin {
  final toolTipKey = GlobalKey<State<Tooltip>>();
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future showAndCloseTooltip() async {
    await Future.delayed(const Duration(milliseconds: 10));
    final dynamic tooltip = toolTipKey.currentState;
    tooltip?.ensureTooltipVisible();
  }

  Future closeTooltip() async {
    await Future.delayed(const Duration(milliseconds: 10));
    final dynamic tooltip = toolTipKey.currentState;
    tooltip?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(context.read<SettingCubit>().state.setting.tutorial!.tooltip <= 1 && widget.isSelected) {
      context.read<SettingCubit>().setTooltip(2);
      showAndCloseTooltip();
    }

    if(widget.isSelected) {
      _controller.forward();
    }else {
      _controller.reverse();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.0 * widget.layout.heightPercent),
      child: Column(
        children: [
          Container(
            width: 328.0 * widget.layout.widthPercent,
            height: 40.0 * widget.layout.heightPercent,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(4.0 * widget.layout.widthPercent),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                elevation: MaterialStateProperty.all(0),
                fixedSize: MaterialStateProperty.all(Size(328.0 * widget.layout.widthPercent, 40.0 * widget.layout.heightPercent)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  return const Color(0xFF3F8FEA);
                }),
              ),
              onPressed: () => widget.select(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.category.title ?? '제목 없음', style: TextStyle(
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                      fontSize: 14.0 * widget.layout.fontPercent),
                  ),
                  Row(
                    children: [
                      Text('${widget.category.habit.length}개', style: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFA8B8CA),
                          fontSize: 14.0 * widget.layout.fontPercent),
                      ),
                      SizedBox(width: 19.0 * widget.layout.widthPercent),
                      widget.category.habit.isNotEmpty
                          ? SvgPicture.asset('assets/images/list_gray_down_icon.svg', width: 10.0 * widget.layout.widthPercent, height: 5.0 * widget.layout.heightPercent)
                          : SizedBox(width: 10.0 * widget.layout.widthPercent, height: 5.0 * widget.layout.heightPercent)
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOutQuad
            ),
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(right: 14.0 * widget.layout.widthPercent, left: 14.0 * widget.layout.widthPercent, top: 12.0 * widget.layout.heightPercent),
                child: Column(
                  children: [
                    w.ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.category.habit.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(widget.category.habit[index].icon ?? 'assets/images/stopwatch_sticker_default_icon.svg', width: 24.0 * widget.layout.widthPercent),
                                SizedBox(width: 6.0 * widget.layout.widthPercent,),
                                Text(widget.category.habit[index].title, style: TextStyle(
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF000000),
                                  fontSize: 14.0 * widget.layout.fontPercent,
                                ),),
                              ],
                            ),
                            SizedBox(
                              height: 10.0 * widget.layout.heightPercent,
                            )
                          ],
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0 * widget.layout.widthPercent),
                            ),
                            context: context, builder: (context) {
                          return StopwatchMakeHabitModal(
                            layout: widget.layout,
                            setTitle: (title) async {
                              context.read<ListCubit>().setTitle(title);
                            },
                            addButton: true,
                            duration: context.read<ListCubit>().state.habit?.presetTime,
                            settingFunction: (duration, index) => context.read<ListCubit>().makeHabit(duration, index),
                            saveHabit: () async => await context.read<ListCubit>().saveHabit(),
                          );
                        }
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(EdgeInsets.zero)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/list_blue_plus_icon.svg'),
                          SizedBox(width: 6.0 * widget.layout.widthPercent),
                          Tooltip(
                            key: toolTipKey,
                            triggerMode: TooltipTriggerMode.manual,
                            padding: EdgeInsets.symmetric(vertical: 6.0 * widget.layout.heightPercent, horizontal: 8.0 * widget.layout.widthPercent),
                            preferBelow: true,
                            message: '카테고리에 습관을 추가해봐요',
                            textStyle: TextStyle(
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFFFFFFF),
                              fontSize: 12.0 * widget.layout.fontPercent,
                            ),
                            decoration: ShapeDecoration(
                                color: const Color(0xFF000000),
                                shape: CustomTooltipShape(
                                    radius: 4.0 * widget.layout.widthPercent,
                                    taleLocation: 50.0
                                )
                            ),
                            child: Text('습관 만들기', style: TextStyle(
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1775E5),
                                fontSize: 14.0 * widget.layout.fontPercent)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}