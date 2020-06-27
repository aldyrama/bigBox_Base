import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutlineButtonApp extends StatefulWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget child;
//  final Function

  OutlineButtonApp({Key key,
    this.padding,
    this.margin,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OutlineButtonAppState();
  }
}

class OutlineButtonAppState extends State<OutlineButtonApp>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
          onPressed: null),
    );
  }

}