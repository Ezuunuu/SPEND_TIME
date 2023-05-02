import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.leftButton, this.rightButton}) : super(key: key);

  final Widget? leftButton;
  final Widget? rightButton;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftButton ?? Container(),
            rightButton ?? Container()
          ],
        ),
      ),
    );
  }
}
