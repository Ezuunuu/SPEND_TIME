import 'package:flutter/material.dart';

class CustomFadeButton extends StatefulWidget {
  const CustomFadeButton(
      {
        Key? key,
        required this.width,
        required this.height,
        required this.color,
        required this.icon,
        required this.isPlay,
        required this.onClicked,
      }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final Widget icon;
  final bool isPlay;
  final void Function() onClicked;

  @override
  State<CustomFadeButton> createState() => _CustomFadeButtonState();
}

class _CustomFadeButtonState extends State<CustomFadeButton> with TickerProviderStateMixin {
  late AnimationController _startAnimationController;
  late Animation<double> _startAnimation;

  @override
  void initState() {
    _startAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _startAnimationController.reverseDuration = const Duration(milliseconds: 100);
    _startAnimation = CurvedAnimation(parent: _startAnimationController, curve: Curves.linear);
    _startAnimation.addListener((){
      setState(() { });
    });
    super.initState();
  }

  @override
  void dispose() {
    _startAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.isPlay) {
      _startAnimationController.reverse();
    } else if(widget.isPlay){
      _startAnimationController.forward();
    }
    return FadeTransition(
      opacity: _startAnimation,
      child: ElevatedButton(
        onPressed: () => widget.onClicked(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) return const Color(0xFF3F8FEA);
            return null;
          }),
        ),
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          child: widget.icon,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
