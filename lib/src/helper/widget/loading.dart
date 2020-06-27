
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiLoading extends StatelessWidget {
  final double opacity;
  final double strokeWidth;
  final Color color;
  final Color titleColor;
  final Brightness brightness;

  const UiLoading({Key key, this.opacity = 1, this.strokeWidth = 3, this.color = Colors.black,
    this.brightness = Brightness.dark, this.titleColor = Colors.white}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withOpacity(opacity),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 35,
              width: 35,
                child: Theme(
                    data: ThemeData(
                        cupertinoOverrideTheme: CupertinoThemeData(
                            brightness: brightness
                        )
                    ),
                    child: CupertinoActivityIndicator())
            ),
            Text("Loading", style: TextStyle(color: titleColor, fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
