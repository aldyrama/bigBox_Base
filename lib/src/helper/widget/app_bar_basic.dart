import 'package:bigbox_flutter/src/value/app_colors.dart';
import 'package:flutter/material.dart';

class BpsBasicAppBar extends StatefulWidget{
  final double elevation;
  final bool isLeading;
  final String title;
  final Color titleColor;
  final List<Widget> action;
  final Icon icon;
  final Color background;
  final FontWeight weight;

  const BpsBasicAppBar({Key key,
    this.elevation = 0,
    this.isLeading = true,
    this.title = "",
    this.titleColor = AppColors.WHITE,
    this.action,
    this.icon,
    this.background = AppColors.WHITE,
    this.weight = FontWeight.normal,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BpsBasicAppBarState();
  }
}

class BpsBasicAppBarState extends State<BpsBasicAppBar>{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: widget.elevation,
      backgroundColor: widget.background,
      title: Text(widget.title, style: TextStyle(color: widget.titleColor, fontWeight: widget.weight),),
      automaticallyImplyLeading: false,
      leading: IconButton(icon: widget.icon,
          onPressed: () => Navigator.pop(context)),
      actions: widget.action
    );
  }
}