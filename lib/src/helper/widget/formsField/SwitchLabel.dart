part of 'index.dart';

class SwitchLabel extends StatelessWidget {
  final bool isOn;
  final String placeholder;
  final ValueChanged<bool> onChanged;
  final double scaleTransform;

  SwitchLabel(this.isOn, this.placeholder, {this.onChanged = null, this.scaleTransform});

  Widget buildSwich(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(color: Colors.transparent,
              child: Row(children: <Widget>[
                Expanded(
                    child: Text(placeholder,
                      style: TextStyle(fontFamily: 'BrandonText',
                      ),
                    )
                ),
                Transform.scale(scale: scaleTransform,
                  child: CupertinoSwitch(value: isOn,
                    activeColor: Color(0xFFED8180),
                      onChanged: (status) {
                        if (onChanged != null) {
                          onChanged(status);
                        }
                  }),
                )
              ]))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildSwich(context),
    );
  }
}
