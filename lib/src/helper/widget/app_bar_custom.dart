import 'package:bigbox_flutter/src/value/app_colors.dart';
import 'package:flutter/material.dart';

class SiapBroCustomAppBar extends StatefulWidget{
  final bool isLeading;
  final String leadingTitle;

  const SiapBroCustomAppBar({Key key,
    this.isLeading = true,
    this.leadingTitle
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SiapBroCustomAppBarState();
  }
}

class SiapBroCustomAppBarState extends State<SiapBroCustomAppBar>{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: leading(widget.leadingTitle),
    );
  }


  Widget leading(String title){
    return widget.isLeading != true ? Container() :
    Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.WHITE),
              onPressed: () => Navigator.pop(context)),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Text(title, style: TextStyle(color: AppColors.WHITE),),
          )
        ],
      ),
    );
  }
}