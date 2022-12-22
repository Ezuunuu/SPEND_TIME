import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
///-
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/setting/setting.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

Duration? d;
int? a;
int index = 0;

class StopwatchSettingModal extends StatefulWidget {
  const StopwatchSettingModal(
      {
        Key? key,
        required this.layout,
        this.duration,
        required this.settingFunction,
      }) : super(key: key);

  final CustomLayoutInfo layout;
  final Duration? duration;
  final void Function(Duration, int) settingFunction;

  @override
  State<StopwatchSettingModal> createState() => _StopwatchSettingModalState();
}

class _StopwatchSettingModalState extends State<StopwatchSettingModal> {
  late CarouselController _carouselController;
  late FixedExtentScrollController _cupertinoController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _cupertinoController = FixedExtentScrollController(initialItem: a ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 14.0 * widget.layout.heightPercent, bottom: 16.0 * widget.layout.heightPercent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24.0 * widget.layout.widthPercent,
                  ),
                  IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/images/back_btn.png',
                    ),
                  ),
                  SizedBox(
                    width: 30.0 * widget.layout.widthPercent,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )
                      ),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Color(index == 0 ? 0xFF3F8FEA : 0xFFA8B8CA)),
                    ),
                    onPressed: () {
                      setState((){
                        _carouselController.animateToPage(0);
                        index = 0;
                      });
                    },
                    child: Text('시간 설정',
                      style: TextStyle(
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFFFFFF),
                        fontSize: 14.0 * widget.layout.fontPercent,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 22.0 * widget.layout.widthPercent,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )
                      ),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Color(index == 1 ? 0xFF3F8FEA : 0xFFA8B8CA)),
                    ),
                    onPressed: () {
                      setState((){
                        _carouselController.animateToPage(1);
                        index = 1;
                      });
                    },
                    child: Text('소리 설정',
                      style: TextStyle(
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFFFFFF),
                        fontSize: 14.0 * widget.layout.fontPercent,
                      ),
                    ),
                  )
                ],
              ),
              CarouselSlider(
                carouselController: _carouselController,
                items: [
                  ModalTimeContent(
                    duration: widget.duration,
                  ),
                  ModalAlarmContent(
                    controller: _cupertinoController,
                    layout: widget.layout,
                    setState: () => setState(() {}),
                  )
                ],
                options: CarouselOptions(
                  initialPage: index,
                  enableInfiniteScroll: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  viewportFraction: 1.0,
                ),
              ),

              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0 * widget.layout.widthPercent),
                  width: double.infinity,
                  height: 56.0 * widget.layout.heightPercent,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          )
                      ),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF3F8FEA)),
                    ),
                    onPressed: () {
                      setState(() { });
                      widget.settingFunction(d ?? Duration.zero, a ?? 0);
                      Navigator.pop(context);
                    },
                    child: Text('설정하기',
                      style: TextStyle(
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFFFFFF),
                        fontSize: 14.0 * widget.layout.fontPercent,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}

class ModalTimeContent extends StatelessWidget {
  const ModalTimeContent(
      {
        Key? key,
        this.duration,
      }) : super(key: key);

  final Duration? duration;


  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(
        initialTimerDuration: duration ?? Duration.zero,
        mode: context.read<SettingCubit>().state.setting.secMinMode == 0 ? CupertinoTimerPickerMode.hms : CupertinoTimerPickerMode.hm,
        onTimerDurationChanged: (duration) {
          d = duration;
        }
    );
  }
}

class ModalAlarmContent extends StatelessWidget {
  const ModalAlarmContent(
      {
        Key? key,
        required this.controller,
        required this.layout,
        required this.setState,
      }) : super(key: key);

  final FixedExtentScrollController controller;
  final CustomLayoutInfo layout;
  final Function setState;

  @override
  Widget build(BuildContext context) {
    final alarm = StopwatchAlarm(layout: layout);
    alarm.getList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 14.0 * layout.heightPercent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('알람', style: TextStyle(
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w700,
              color: const Color(0xFF496D97),
              fontSize: 18.0 * layout.fontPercent,
            ),),
            SizedBox(
              width: 17.0 * layout.widthPercent,
            ),
            CupertinoSwitch(
                value: !(a == 99),
                onChanged: (val) {
                  if(!val) {
                    a = 99;
                  }
                  setState();
                },
              activeColor: const Color(0xFF3F8FEA),
            )
          ],
        ),
        SizedBox(
          height: 12.0 * layout.heightPercent,
        ),
        Expanded(
          child: CupertinoPicker(
            scrollController: controller,
            itemExtent: 50.0,
            onSelectedItemChanged: (i) {
              a = i;
              setState();
            },
            children: alarm.alarmNameList
          ),
        ),
      ],
    );
  }
}