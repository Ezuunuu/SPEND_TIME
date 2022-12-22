import 'dart:ui';

import 'package:flutter/material.dart';
///-
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_time/screen/setting/setting.dart';
///-
import 'package:spend_time/utils/utils.dart';
import 'package:spend_time/config/config.dart';
import 'package:spend_time/widgets/widgets.dart';
import 'package:spend_time/screen/stopwatch/stopwatch.dart';
///-
export '../model/stopwatch_alarm.dart';
export 'stopwatch_box_item_view.dart';
export 'stopwatch_category_box_modal.dart';
export 'stopwatch_complete_dialog.dart';
export 'stopwatch_habit_box_modal.dart';
export 'stopwatch_make_habit_modal.dart';
export 'stopwatch_reset_dialog.dart';
export 'stopwatch_setting_button.dart';
export 'stopwatch_setting_modal.dart';
export 'stopwatch_warning_alert_dialog.dart';

class StopwatchView extends StatelessWidget {
  const StopwatchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d("Stopwatch view");
    final layout = CustomLayoutInfo(MediaQuery.of(context));
    return BlocBuilder<StopwatchCubit, StopwatchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFEEF0F6),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0 * layout.widthPercent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(40.0 * layout.heightPercent, 40.0 * layout.heightPercent,)),
                          shape: MaterialStateProperty.all(const CircleBorder()),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                            return const Color(0xFF3F8FEA);
                          }),
                        ),
                          onPressed: () { },
                          child: SvgPicture.asset(
                            'assets/images/stopwatch_hard_mode_icon.svg',
                          ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(40.0 * layout.heightPercent, 40.0 * layout.heightPercent)),
                          shape: MaterialStateProperty.all(const CircleBorder()),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                            return const Color(0xFF3F8FEA);
                          }),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: const Color(0xFFFFFFFF),
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0 * layout.widthPercent),
                              ),
                              context: context, builder: (context) {
                                return StopwatchCategoryBoxModal(
                                    layout: layout,
                                );
                              }
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/images/stopwatch_folder_icon.svg',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.5 * layout.heightPercent,
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () async {
                      if(state.status != StopwatchStatus.running && state.status != StopwatchStatus.pause) {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0 * layout.widthPercent),
                            ),
                            context: context, builder: (context) {
                              return StopwatchMakeHabitModal(
                                layout: layout,
                                duration: state.habit?.presetTime,
                                initialTitle: state.habit?.title,
                                setTitle: (title) => context.read<StopwatchCubit>().setTitle(title),
                                settingFunction: (duration, alarm) => context.read<StopwatchCubit>().stopwatchModalSetting(duration, alarm),
                              );
                            }
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/images/stopwatch_sticker_default_icon.svg',
                    ),
                    iconSize: 45.0 * layout.heightPercent,
                  ),
                ),
                SizedBox(
                  height: 25.5 * layout.heightPercent,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0.0)
                  ),
                  onPressed: () {
                    if(state.status != StopwatchStatus.running && state.status != StopwatchStatus.pause) {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0 * layout.widthPercent),
                          ),
                          context: context, builder: (context) {
                        return StopwatchMakeHabitModal(
                          layout: layout,
                          duration: state.habit?.presetTime,
                          initialTitle: state.habit?.title,
                          setTitle: (title) => context.read<StopwatchCubit>().setTitle(title),
                          settingFunction: (duration, index) => context.read<StopwatchCubit>().stopwatchModalSetting(duration, index),
                        );
                          }
                      );
                    }
                  },
                  child: Text((state.habit?.title ?? '습관을 입력해 보세요') == '' ? '습관을 입력해 보세요' : state.habit!.title,
                    style: TextStyle(
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF76B5F4),
                      fontSize: 22.0 * layout.fontPercent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0 * layout.heightPercent,
                ),
                Text(getStringFromDuration(state.status == StopwatchStatus.running ? state.habit?.stopwatch.last.time.currentTime ?? Duration.zero : state.habit?.presetTime ?? Duration.zero, SecMinMode.values[context.read<SettingCubit>().state.setting.secMinMode]),
                  style: TextStyle(
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000000),
                    fontSize: 44.0 * layout.fontPercent,
                    fontFeatures: const [FontFeature.tabularFigures()]
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 26.0 * layout.heightPercent,
                ),
                StopwatchSettingButton(
                  layout: layout,
                  visible: state.status == StopwatchStatus.init || state.status == StopwatchStatus.setting,
                ),
                SizedBox(
                  height: 70.0 * layout.heightPercent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFadeButton(
                      width: 60.0 * layout.heightPercent,
                      height: 60.0 * layout.heightPercent,
                      color: state.status != StopwatchStatus.pause ? const Color(0xFFC8D3E2) : const Color(0xFF3F8FEA),
                      icon: state.status != StopwatchStatus.pause ? Icon(Icons.pause, color: Colors.white, size: 24.0 * layout.heightPercent) : const Text('다시\n시작', textAlign: TextAlign.center,),
                      isPlay: state.status!.isRunning || state.status == StopwatchStatus.pause,
                      onClicked: () async => await context.read<StopwatchCubit>().pause(),
                    ),
                    SizedBox(
                      width: 110.0 * layout.heightPercent,
                      height: 110.0 * layout.heightPercent,
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: CustomPlayPauseButton(
                          width: 88.0 * layout.heightPercent,
                          height: 88.0 * layout.heightPercent,
                          color: const Color(0xFF3F8FEA),
                          icon: state.status!.isRunning || state.status == StopwatchStatus.pause ? Icons.stop : Icons.play_arrow,
                          iconSize: 42.0 * layout.heightPercent,
                          isPlay: state.status!.isRunning,
                          onClicked: () async {
                            if((state.habit?.presetTime ?? Duration.zero).inMilliseconds > 1000 && state.habit?.mode == StopwatchMode.timer.index && state.status != StopwatchStatus
                                .init) {
                              stopwatchWarningAlertDialog(context, layout);
                            }else {
                              if(state.status == StopwatchStatus.running || state.status == StopwatchStatus.pause) {
                                stopwatchCompleteDialog(context, layout, SvgPicture.asset(state.habit!.icon ?? 'assets/images/stopwatch_sticker_default_icon.svg'));
                              }else {
                                await context.read<StopwatchCubit>().start();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    CustomFadeButton(
                      width: 60.0 * layout.heightPercent,
                      height: 60.0 * layout.heightPercent,
                      color: const Color(0xFFC8D3E2),
                      icon: const Icon(Icons.refresh),
                      isPlay: state.status!.isRunning || state.status == StopwatchStatus.pause,
                      onClicked: () async {
                        if(state.status == StopwatchStatus.running) {
                          stopwatchResetDialog(context, layout);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
