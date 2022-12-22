import 'package:flutter/material.dart';
///-
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///-
import 'package:spend_time/config/config.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';

class StopwatchSettingButton extends StatefulWidget {
  const StopwatchSettingButton(
      {
        Key? key,
        required this.layout,
        required this.visible,
      }) : super(key: key);

  final CustomLayoutInfo layout;
  final bool visible;

  @override
  State<StopwatchSettingButton> createState() => _StopwatchSettingButtonState();
}

class _StopwatchSettingButtonState extends State<StopwatchSettingButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.reverseDuration = const Duration(milliseconds: 100);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation.addListener((){
      setState(() { });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.visible) {
      _animationController.forward();
    }else {
      _animationController.reverse();
    }

    return BlocBuilder<StopwatchCubit, StopwatchState>(
      builder: (context, state) {
        return FadeTransition(
          opacity: _animation,
          child: SizedBox(
            width: 164.0 * widget.layout.widthPercent,
            child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )
                  ),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) return const Color(0xFF3F8FEA);
                    return null;
                  }),
                ),
                onPressed: () {
                  if(_animationController.isCompleted) {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        context: context, builder: (context) {
                      return StopwatchSettingModal(
                        layout: widget.layout,
                        duration: state.habit?.presetTime,
                        settingFunction: (duration, index) async => await context.read<StopwatchCubit>().stopwatchModalSetting(duration, index),
                      );
                    }
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/stopwatch_group_icon.svg',
                    ),
                    SizedBox(
                      width: 8.0 * widget.layout.widthPercent,
                    ),
                    Text('목표시간 설정하기',
                      style: TextStyle(
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1775E5),
                        fontSize: 14.0 * widget.layout.fontPercent,
                      ),
                    ),
                  ],
                )
            ),
          ),
        );
      }
    );
  }
}
