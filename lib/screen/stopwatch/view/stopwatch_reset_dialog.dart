import 'package:flutter/material.dart';
///-
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/widgets/widgets.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

void stopwatchResetDialog(BuildContext context, CustomLayoutInfo layout) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          width: 280.0 * layout.widthPercent,
          height: 145.0 * layout.heightPercent,
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Text(
            '처음부터 하시겠어요?',
            style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w800,
              color: Color(0xFF000000),
              fontSize: 20.0,
            ),
            textAlign: TextAlign.start,
          ),
          content: const Text(
            '지금까지 기록한 시간이 사라져요.',
            style: TextStyle(
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w500,
                color: Color(0xFF000000),
                fontSize: 14.0,
                height: 1.25
            ),
            textAlign: TextAlign.start,
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('안 할래', style: TextStyle(
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
                      await context.read<StopwatchCubit>().restart();
                      Navigator.of(context).pop();
                    },
                    child: const Text('처음부터', style: TextStyle(
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
}