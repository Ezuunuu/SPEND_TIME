import 'package:flutter/material.dart';
///-
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/utils/utils.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/setting/setting.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

class StopwatchMakeHabitModal extends StatefulWidget {
  const StopwatchMakeHabitModal(
      {
        Key? key,
        required this.layout,
        required this.setTitle,
        this.initialTitle,
        this.duration,
        this.addButton = false,
        required this.settingFunction,
        this.saveHabit
      }) : super(key: key);

  final CustomLayoutInfo layout;
  final Future<void> Function(String) setTitle;
  final String? initialTitle;
  final Duration? duration;
  final bool addButton;
  final Future<void> Function(Duration, int) settingFunction;
  final Function? saveHabit;

  @override
  State<StopwatchMakeHabitModal> createState() => _StopwatchMakeHabitModalState();
}

class _StopwatchMakeHabitModalState extends State<StopwatchMakeHabitModal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 16.0 * widget.layout.widthPercent,
              right: 16.0 * widget.layout.widthPercent,
              top: 22.0 * widget.layout.heightPercent,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('습관 만들기', style: TextStyle(
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w800,
                color: const Color(0xFF000000),
                fontSize: 20.0 * widget.layout.fontPercent),
              ),
              SizedBox(height: 14.0 * widget.layout.heightPercent,),
              Row(
                children: [
                  SizedBox(
                    width: 100.0 * widget.layout.widthPercent,
                    height: 40.0 * widget.layout.heightPercent,
                    child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFF4F7FF)),
                          elevation: MaterialStateProperty.all(0),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                            return Colors.white;
                          }),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('스티커', style: TextStyle(
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF496D97),
                              fontSize: 14.0 * widget.layout.fontPercent),
                            ),
                            SizedBox(width: 7.0 * widget.layout.widthPercent),
                            SvgPicture.asset(
                              'assets/images/stopwatch_sticker_default_icon.svg',
                              width: 18.0 * widget.layout.heightPercent,
                              height: 18.0 * widget.layout.heightPercent,
                            )
                          ],
                        )
                    ),
                  ),
                  SizedBox(width: 8.0 * widget.layout.widthPercent),
                  Container(
                    width: 220.0 * widget.layout.widthPercent,
                    height: 40.0 * widget.layout.heightPercent,
                    color: const Color(0xFFF4F7FF),
                    child: TextFormField(
                      initialValue: widget.initialTitle ?? "",
                      onChanged: (v) async {
                        await widget.setTitle(v);
                      },
                      decoration: InputDecoration(
                        hintText: '습관 이름(14글자)',
                        hintStyle: TextStyle(
                            color: const Color(0xFFA8B8CA),
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0 * widget.layout.fontPercent
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 14.0 * widget.layout.widthPercent, vertical: 8.0 * widget.layout.heightPercent)
                      ),

                    ),
                  )
                ],
              ),
              SizedBox(height: 12.0 * widget.layout.heightPercent),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFF4F7FF)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                      return Colors.white;
                    }),
                    elevation: MaterialStateProperty.all(0)
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0 * widget.layout.widthPercent),
                        ),
                        context: context, builder: (context) {
                      return StopwatchSettingModal(
                        layout: widget.layout,
                        duration: widget.duration ?? Duration.zero,
                        settingFunction: (duration, alarm) async => widget.settingFunction(duration, alarm),
                      );
                    }
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '목표시간 설정',
                          style: TextStyle(
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF496D97),
                            fontSize: 14.0 * widget.layout.fontPercent),
                          children: [
                            TextSpan(
                                text: '(선택)',
                                style: TextStyle(
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF496D97),
                                  fontSize: 12.0 * widget.layout.fontPercent),
                            ),
                          ]
                        ),
                      ),
                      Text(msToStringDuration((widget.duration ?? Duration.zero).inMilliseconds, SecMinMode.values[context.read<SettingCubit>().state.setting.secMinMode]), style: TextStyle(
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF496D97),
                        fontSize: 14.0 * widget.layout.fontPercent),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28.0 * widget.layout.heightPercent),
              widget.addButton ? ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  elevation: MaterialStateProperty.all(0),
                  fixedSize: MaterialStateProperty.all(Size(328.0 * widget.layout.widthPercent, 56.0 * widget.layout.heightPercent)),
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF1775E5)),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                    return const Color(0xFF3F8FEA);
                  }),
                ),
                onPressed: () async {
                  if(widget.saveHabit != null) {
                    await widget.saveHabit!();
                  }
                  Navigator.pop(context);
                },
                child: Text('추가하기', style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF),
                    fontSize: 18.0 * widget.layout.fontPercent),
                ),

              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
