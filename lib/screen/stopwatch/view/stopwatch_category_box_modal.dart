import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/list/list.dart' as l;
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

class StopwatchCategoryBoxModal extends StatefulWidget {
  const StopwatchCategoryBoxModal(
      {
        Key? key,
        required this.layout,
      }) : super(key: key);

  final CustomLayoutInfo layout;

  @override
  State<StopwatchCategoryBoxModal> createState() => _HabitBoxModalState();
}

class _HabitBoxModalState extends State<StopwatchCategoryBoxModal> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 16.0 * widget.layout.widthPercent,
            right: 16.0 * widget.layout.widthPercent,
            top: 22.0 * widget.layout.heightPercent,
            bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: BlocBuilder<l.ListCubit, l.ListState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('습관 보관함', style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF000000),
                    fontSize: 20.0 * widget.layout.fontPercent),
                ),
                SizedBox(height: 24.0 * widget.layout.heightPercent,),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.category.length,
                  itemBuilder: (context, index) {
                    return StopwatchBoxItemView(
                      layout: widget.layout,
                      title: state.category[index].title,
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: const Color(0xFFFFFFFF),
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0 * widget.layout.widthPercent),
                            ),
                            context: context, builder: (context) {
                          return StopwatchHabitBoxModal(
                            layout: widget.layout,
                            category: state.category[index],
                          );
                        }
                        );
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
