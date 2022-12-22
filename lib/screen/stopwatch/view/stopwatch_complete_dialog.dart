import 'package:flutter/material.dart';
///-
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/widgets/widgets.dart';
import 'package:spend_time/screen/stopwatch/cubit/stopwatch_cubit.dart';

void stopwatchCompleteDialog(BuildContext context, CustomLayoutInfo layout, Widget icon) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          width: 280.0 * layout.widthPercent,
          height: 306.0 * layout.heightPercent,
          backgroundColor: const Color(0xFFFFFFFF),
          title: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 32.0 * layout.heightPercent,
                ),
                icon,
                SizedBox(
                  height: 16.0 * layout.heightPercent,
                ),
                const Text(
                  '첫 습관을 끝마쳤어요',
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF000000),
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          content: const Text(
            '훌륭해요! 시작이 반이라고들 하죠.\n작은 습관부터 차근차근 오래오래 해봐요!',
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w500,
              color: Color(0xFF000000),
              fontSize: 14.0,
              // height: 1.25
            ),
            textAlign: TextAlign.start,
          ),
          button: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 124.0 * layout.widthPercent,
                    height: 36.0 * layout.heightPercent,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF000000))
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('조금만 더 할래', style: TextStyle(
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
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF76B5F4))
                        ),
                        onPressed: () async {
                          /// TODO: 다음 습관으로
                          Navigator.of(context).pop();
                        },
                        child: const Text('다음 습관으로', style: TextStyle(
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
              SizedBox(
                height: 10.0 * layout.heightPercent,
              ),
              SizedBox(
                width: 256.0 * layout.widthPercent,
                height: 36.0 * layout.heightPercent,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF3F8FEA))
                    ),
                    onPressed: () async {
                      await context.read<StopwatchCubit>().complete();
                      await context.read<ListCubit>().loadCategory();
                      Navigator.of(context).pop();
                    },
                    child: const Text('여기까지만 할래', style: TextStyle(
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                      fontSize: 14.0,
                    ),
                      textAlign: TextAlign.start,)
                ),
              ),
            ],
          ),
        );
      });
}