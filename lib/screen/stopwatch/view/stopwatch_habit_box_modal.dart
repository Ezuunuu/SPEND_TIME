import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';
import 'package:spend_time/screen/list/list.dart' as list;

class StopwatchHabitBoxModal extends StatelessWidget {
  const StopwatchHabitBoxModal(
      {
        Key? key,
        required this.layout,
        required this.category
      }) : super(key: key);

  final CustomLayoutInfo layout;
  final list.CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 16.0 * layout.widthPercent,
            right: 16.0 * layout.widthPercent,
            top: 22.0 * layout.heightPercent,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BlocBuilder<list.ListCubit, list.ListState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category.title ?? '제목없음', style: TextStyle(
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF000000),
                      fontSize: 20.0 * layout.fontPercent),
                  ),
                  SizedBox(height: 24.0 * layout.heightPercent),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: category.habit.length,
                    itemBuilder: (context, index) {
                      return StopwatchBoxItemView(
                        layout: layout,
                        icon: SvgPicture.asset(category.habit[index].icon ?? 'assets/images/stopwatch_sticker_default_icon.svg'),
                        title: category.habit[index].title,
                        onPressed: () async {
                          await context.read<StopwatchCubit>().setHabit(category, index);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}
