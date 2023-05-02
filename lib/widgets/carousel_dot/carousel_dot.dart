import 'package:flutter/material.dart';

class CarouselDot extends StatefulWidget {
  const CarouselDot(
      {
        Key? key,
        required this.size,
        required this.count,
        required this.index,
        required this.selectedColor,
        required this.unselectedColor,
      }) : super(key: key);

  final double size;

  final int count;
  final int index;

  final Color selectedColor;
  final Color unselectedColor;

  @override
  State<CarouselDot> createState() => _CarouselDotState();
}

class _CarouselDotState extends State<CarouselDot> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.count, (index) {
          final AnimationController animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
          final Animation<double> animation = CurvedAnimation(
            parent: animationController,
            curve: Curves.fastOutSlowIn,
          );
          Tween<double> tween = Tween(begin: 0.8, end: 1);
          if (index == widget.index) {
            animationController.forward();
          } else {
            // _animationController.reverse();
          }
          return Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: ScaleTransition(
              scale: tween.animate(animation),
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(color: widget.index == index ? widget.selectedColor : widget.unselectedColor, borderRadius: BorderRadius.circular(100.0)),
              ),
            ),
          );
        }),
      ),
    );
  }
}
