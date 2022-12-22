import 'package:flutter/material.dart';

class CustomSlideButton extends StatefulWidget {
  const CustomSlideButton(
      {
        Key? key,
        required this.width,
        required this.height,
        required this.color,
        required this.icon,
        required this.iconSize,
        required this.offset,
        required this.isPlay,
        required this.onClicked,
      }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final IconData icon;
  final double iconSize;
  final Offset offset;
  final bool isPlay;
  final void Function() onClicked;

  @override
  State<CustomSlideButton> createState() => _CustomSlideButtonState();
}

class _CustomSlideButtonState extends State<CustomSlideButton> with TickerProviderStateMixin {
  late AnimationController _startAnimationController;
  late Animation<Offset> _startAnimation;

  @override
  void initState() {
    _startAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _startAnimationController.reverseDuration = const Duration(milliseconds: 300);
    _startAnimation = Tween(begin: Offset.zero, end: widget.offset).animate(CurvedAnimation(parent: _startAnimationController, curve: Curves.linear));
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
      Future.delayed(const Duration(milliseconds: 500), () {
        _startAnimationController.forward();
      });
    }
    return SlideTransition(
      position: _startAnimation,
      transformHitTests: true,
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
          width: widget.width,
          height: widget.height,
          child: Icon(widget.icon, color: Colors.white, size: widget.iconSize),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
          ),
        ),
      ),
    );
  }
}
