
part of 'index.dart';

class CheckBoxLabel extends StatelessWidget {
  final bool isCheck;
  final ValueChanged<bool> onChanged;
  final Widget child;
  final Color activeColor;
  final Color inActiveColor;
  final Color checkColor;

  CheckBoxLabel(this.isCheck,{this.onChanged,this.child, this.activeColor, this.checkColor, this.inActiveColor});

  void setonCheck({bool value}) {
    if (onChanged != null) {
      bool result = value != null ? value : !isCheck;
      onChanged(result);
    }
  }

  Widget buildCheckBox(BuildContext context) {
    Widget widget = child != null ? child : Container();

    return GestureDetector(
        onTap: () {
          setonCheck();
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  color: Colors.transparent,
                  child: Row(children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: inActiveColor,
                      ),
                      child: Checkbox(
                        activeColor: activeColor,
                        checkColor: checkColor,
                        value: isCheck,
                        onChanged: (isChanged) {
                          setonCheck(value: isChanged);
                        },
                      ),
                    ),
                    widget
                  ]))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return buildCheckBox(context);
  }
}
