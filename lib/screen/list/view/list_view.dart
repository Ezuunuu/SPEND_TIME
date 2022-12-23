import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as w;
///-
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/setting/setting.dart';
import 'package:spend_time/widgets/widgets.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/screen/list/view/list_category_view.dart';

final toolTipKey = GlobalKey<State<Tooltip>>();
final textController = TextEditingController();

class ListView extends StatelessWidget {
  const ListView({Key? key}) : super(key: key);

  Future showAndCloseTooltip() async {
    await Future.delayed(const Duration(milliseconds: 10));
    final dynamic tooltip = toolTipKey.currentState;
    tooltip?.ensureTooltipVisible();
  }

  @override
  Widget build(BuildContext context) {
    logger.d("List view");
    final layout = CustomLayoutInfo(MediaQuery.of(context));
    if(context.read<SettingCubit>().state.setting.tutorial!.tooltip <= 0) {
      context.read<SettingCubit>().setTooltip(1);
      showAndCloseTooltip();
    }

    return BlocListener<ListCubit, ListState>(
      listenWhen: (previous, current) => (previous.status != current.status) || (previous.errorMsg != current.errorMsg),
      listener: (context, state) {
        switch(state.status) {
          case ListStatus.error:
            ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(
              backgroundColor: const Color(0xFF000000),
              margin: EdgeInsets.only(left: 18.0 * layout.widthPercent, right: 18.0 * layout.widthPercent, bottom: 20.0 * layout.heightPercent),
              behavior: SnackBarBehavior.floating,
              content: Text(state.errorMsg ?? '알 수 없는 오류입니다. error code 00', style: TextStyle(
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w400,
                color: const Color(0xFFFFFFFF),
                fontSize: 12.0 * layout.fontPercent,
              )),
            ));
            break;
          case ListStatus.saveComplete:
            ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(
              backgroundColor: const Color(0xFF000000),
              margin: EdgeInsets.only(left: 18.0 * layout.widthPercent, right: 18.0 * layout.widthPercent, bottom: 20.0 * layout.heightPercent),
              behavior: SnackBarBehavior.floating,
              content: Text("새로운 카테고리를 만들었어요", style: TextStyle(
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w400,
                color: const Color(0xFFFFFFFF),
                fontSize: 12.0 * layout.fontPercent,
              )),
            ));
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<ListCubit, ListState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: const Color(0xFFEEF0F6),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 40.0 * layout.heightPercent,
                      right: 16.0 * layout.widthPercent,
                      left: 16.0 * layout.widthPercent
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('습관 보관함', style: TextStyle(
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF000000),
                        fontSize: 22.0 * layout.fontPercent,
                      )),
                      SizedBox(height: 24.0 * layout.heightPercent,),
                      Tooltip(
                        key: toolTipKey,
                        triggerMode: TooltipTriggerMode.manual,
                        padding: EdgeInsets.symmetric(vertical: 6.0 * layout.heightPercent, horizontal: 8.0 * layout.widthPercent),
                        preferBelow: true,
                        message: '습관 카테고리를 만들 수 있어요',
                        textStyle: TextStyle(
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFFFFFF),
                          fontSize: 12.0 * layout.fontPercent,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF000000),
                          shape: CustomTooltipShape(
                              radius: 4.0 * layout.widthPercent
                          )
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 328.0 * layout.widthPercent,
                          height: 40.0 * layout.heightPercent,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(4.0 * layout.widthPercent),
                          ),
                          child: FocusScope(
                            child: Focus(
                              onFocusChange: (focus) => context.read<ListCubit>().setFocus(focus),
                              child: TextFormField(
                                controller: textController,
                                onChanged: (v) async {
                                  context.read<ListCubit>().setText(v);
                                },
                                textAlignVertical: TextAlignVertical.center,
                                maxLength: 14,
                                decoration: InputDecoration(
                                    counterText: '',
                                    suffixIcon: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onPressed: () async {
                                        await context.read<ListCubit>().saveCategory();
                                        textController.clear();
                                      },
                                      icon: state.focusFlag ? SvgPicture.asset('assets/images/list_blue_plus_icon.svg') : SvgPicture.asset('assets/images/list_gray_plus_icon.svg'),
                                    ),
                                    suffixIconColor: const Color(0xFFA8B8CA),
                                    hintText: '카테고리 이름을 입력하세요 (14글자)',
                                    hintStyle: TextStyle(
                                        color: const Color(0xFFA8B8CA),
                                        fontFamily: 'SUIT',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0 * layout.fontPercent
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0 * layout.heightPercent),
                      state.status == ListStatus.loading ?
                      CustomShimmerList(
                        width: 328.0 * layout.widthPercent,
                        height: 40.0 * layout.heightPercent,
                        borderRadius: BorderRadius.circular(4.0 * layout.widthPercent),
                        paddingSize: 12.0 * layout.heightPercent,
                      ) :
                      w.ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.category.length,
                        itemBuilder: (BuildContext context, int index) {
                          logger.d(state.category[index].title);
                          logger.d(state.category[index].habit.length);
                          logger.d(state.category[index].habit[0].stopwatch.length);
                          logger.d(state.category[index].habit[0].stopwatch[0].time.startTime);
                          if(state.category[index].title == "저장하지 않은 카테고리" && state.category[index].habit.length == 1 && state.category[index].habit[0].stopwatch.length == 1 && state.category[index].habit[0].stopwatch[0].time.startTime == 0) return const SizedBox();
                          return ListCategoryView(
                              category: state.category[index],
                              layout: layout,
                              isSelected: state.selectIndex == index,
                              select: () => context.read<ListCubit>().select(index),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
