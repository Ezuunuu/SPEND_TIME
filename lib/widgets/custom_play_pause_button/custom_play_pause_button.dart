import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPlayPauseButton extends StatefulWidget {
  const CustomPlayPauseButton(
      {
        Key? key,
        required this.width,
        required this.height,
        required this.color,
        required this.icon,
        required this.iconSize,
        required this.isPlay,
        required this.onClicked,
      }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final IconData icon;
  final double iconSize;
  final bool isPlay;
  final void Function() onClicked;

  @override
  State<CustomPlayPauseButton> createState() => _CustomPlayPauseButtonState();
}

class _CustomPlayPauseButtonState extends State<CustomPlayPauseButton> with TickerProviderStateMixin {
  late AnimationController _breathAnimationController;
  late Animation _breathAnimation;

  late AnimationController _startAnimationController;
  late Animation _startAnimation;

  @override
  void initState() {
    _breathAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
    _breathAnimationController.reverseDuration = const Duration(milliseconds: 500);
    _breathAnimation = Tween(begin: 2.0, end: 15.0).animate(_breathAnimationController);
    _breathAnimation.addListener((){
      setState(() { });
    });

    _startAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _startAnimationController.reverseDuration = const Duration(milliseconds: 200);
    _startAnimation = Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _startAnimationController, curve: Curves.easeOutQuad));
    _startAnimation.addListener((){
      setState(() { });
    });
    super.initState();
  }

  @override
  void dispose() {
    _breathAnimationController.dispose();
    _startAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.isPlay) {
      _breathAnimationController.reverse();
    } else if(widget.isPlay && !_breathAnimationController.isAnimating){
      _startAnimationController.forward().then((value) => _startAnimationController.reverse());
      _breathAnimationController.repeat(reverse: true);
    }
    return Container(
      width: widget.width * _startAnimation.value,
      height: widget.height * _startAnimation.value,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          boxShadow: [BoxShadow(
              color: const Color(0xFFCFE4FD),
              blurRadius: _breathAnimation.value,
              spreadRadius: _breathAnimation.value
          )]
      ),
      child: ElevatedButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            widget.onClicked();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            backgroundColor: MaterialStateProperty.all(const Color(0xFF3F8FEA)),
            overlayColor: MaterialStateProperty.all(const Color(0xFF3F8FEA))
          ),
          child: Icon(widget.icon, color: Colors.white, size: widget.iconSize * _startAnimation.value)
      ),
    );
  }
}
