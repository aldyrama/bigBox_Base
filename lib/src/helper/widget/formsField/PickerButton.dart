part of 'index.dart';

class PickerButton extends StatefulWidget {
  final String placeholder;
  final ValueChanged<String> onValueChanged;
  final List<String> content;

  PickerButton(this.content, this.placeholder, {this.onValueChanged = null});

  @override
  State<StatefulWidget> createState() {
    return PickerButtonState();
  }
}

class PickerButtonState extends State<PickerButton> {

  String currentValue;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = widget.content.map((value) {
      return DropdownMenuItem(
        value: value,
        child: Text(value),
      );
    }).toList();
    return items;
  }

  Widget dropDownHint() {
    if (currentValue == null) {
      return Container();
    }
    return Positioned(
        left: 0.0,
        top: 0.0,
        child: Text(
          widget.placeholder,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ));
  }

  Widget buildDropDownButton() {
    return Container(
//        margin: EdgeInsets.only(top: 10.0),
        child:
            Stack(alignment: AlignmentDirectional.centerEnd, children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 3.0),
//              decoration: new BoxDecoration(
//                  border: new Border(bottom: BorderSide(color: Colors.black))),
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: Text(widget.placeholder),
                      value: currentValue,
                      iconSize: 0.0,
                      items: getDropDownMenuItems(),
                      onChanged: (value) {
                        setState(() {
                          currentValue = value;
                        });
                        if(widget.onValueChanged != null){
                          widget.onValueChanged(currentValue);
                        }
                      }))),
          Icon(Icons.arrow_drop_down),
          dropDownHint()
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return buildDropDownButton();
  }

}
