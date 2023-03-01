import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;
  final Color? backgroundColor;
  const CustomAppBar({Key? key, required this.child, this.height = 0,this.backgroundColor = Colors.white}) : super(key: key);
  @override
  State<CustomAppBar> createState() => CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height +
            MediaQuery.of(context).padding.top, // 流海高度
        width: double.infinity,
        color: widget.backgroundColor,
        child: SafeArea(
          top: true,
          bottom: false,
          child: widget.child,
        ));
  }
}
