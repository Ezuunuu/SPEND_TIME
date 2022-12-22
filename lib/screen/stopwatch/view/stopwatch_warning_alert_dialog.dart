import 'package:flutter/material.dart';
///-
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/list/list.dart';
import 'package:spend_time/widgets/widgets.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

void stopwatchWarningAlertDialog(BuildContext context, CustomLayoutInfo layout) {
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
                SvgPicture.asset(
                  'assets/images/stopwatch_folder_icon.svg',
                  width: 60.0 * layout.heightPercent,
                  height: 60.0 * layout.heightPercent,
                ),
                SizedBox(
                  height: 16.0 * layout.heightPercent,
                ),
                const Text(
                  '잠깐만요!',
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
            '아직 목표시간에 도달하지 못했어요.\n그래도 그만하시겠어요?',
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
              SizedBox(
                width: 256.0 * layout.widthPercent,
                height: 36.0 * layout.heightPercent,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF000000))
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('이어서 할래', style: TextStyle(
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                        fontSize: 14.0,
                    ),
                      textAlign: TextAlign.start,)
                ),
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
                    child: const Text('그만 할래', style: TextStyle(
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