part of 'index.dart';

typedef String MapToString<T>(T value);

class PickerField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final ValueChanged onValueChanged;
  final FormFieldValidator<String> validator;
  final GlobalKey<PickerFieldState> key;
  final List content;
  final MapToString mapContentToString;
  final Image image;
  final InputBorder inputBorder;
  final bool required;
  final bool cupertinoPicker;

  PickerField(this.content, this.placeholder, this.controller,
      {
        this.mapContentToString,
        this.onValueChanged = null,
        this.validator = null,
        this.key = null,
        this.image,
        this.required = true,
        this.inputBorder,
        this.cupertinoPicker = true
      });

  @override
  State<StatefulWidget> createState() {
    return PickerFieldState();
  }
}

class PickerFieldState extends State<PickerField> {
  bool valid = true;
  final pickerFieldKey = GlobalKey<FormFieldState<String>>();
  Object selectedObject;
  int idxResult;

  void pickerTaped() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    Function mapToString = widget.mapContentToString != null
        ? widget.mapContentToString
        : (value) => value.toString();

    List<String> display = widget.content.map((value) {
      String isi = mapToString(value);
      return isi;
    }).toList();

    idxResult = await showPickerModal(context,
        title: widget.placeholder, content: display);
    if (idxResult != null) {
      print("data idx : ${idxResult}");
      widget.controller.text = display[idxResult];
      selectedObject = widget.content[idxResult];

      if (widget.onValueChanged != null) {
        widget.onValueChanged(selectedObject);
      }
    }
    pickerFieldKey.currentState.validate();
  }

  Widget buildPickerView(BuildContext context) {
    double iconTopPosition = valid == true ? 22.0 : 15.0;

    return Container(
        child:
            Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
      Row(
        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.symmetric(vertical: 10.0),
//            child: Padding(
//                padding: EdgeInsets.only(right: 8.0), child: widget.image),
//          ),
          Flexible(
            child: TextFormField(
              key: pickerFieldKey,
              style: TextStyle(
                fontFamily: 'BrandonText',
              ),
              decoration: InputDecoration(
                border: widget.inputBorder,
                labelText: widget.placeholder,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                ),
              ),
              controller: widget.controller,
              validator: (String value) {
                bool isValid = true;
                String alert;
                if (value.isEmpty && widget.required) {
                  return widget.placeholder + ' is required';
                } else if (widget.validator != null) {
                  alert = widget.validator(value);
                  if (alert != null) {
                    isValid = false;
                  }
                }

                setState(() {
                  valid = isValid;
                });
                return alert;
              },
            ),
          )
        ],
      ),
      Positioned(
          child: Container(
              margin: EdgeInsets.only(top: iconTopPosition),
              child: Icon(Icons.arrow_drop_down)),
          right: 0.0),
      SizedBox(
          height: 65.0,
          child: GestureDetector(
              onTap: () => pickerTaped(),
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(10.0),
              )))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return buildPickerView(context);
  }

  Future<int> showPickerModal(BuildContext context,
      {String title = null, List<String> content = const []}) async {
    double heightCell = 50.0;
    double heightTotal = content.length.toDouble() * heightCell;
    heightTotal = heightTotal + 60.0 < 350.0 ? heightTotal + 60.0 : 350.0;

    int result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          int selectitem = 0;
          return widget.cupertinoPicker ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(17.0),
                          topRight: const Radius.circular(17.0)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: RaisedButton(
                            elevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            color: AppColors.TRANSPARENT,
                            child: Text("Done", style: TextStyle(
                                color: AppColors.BLACK, fontSize: 14, fontWeight: FontWeight.bold),),
                            onPressed: () {
                              print("item selected : ${content[selectitem]}");
                              Navigator.pop(context);
                              setState(() {
                                idxResult = selectitem;
                                widget.controller.text = content[selectitem];
                              });

                            }
                        ),
                      )
                    ],
                  )
              ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(17.0),
                        topRight: const Radius.circular(17.0)
                    )
                ),
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 40,
                  looping: false,
                  onSelectedItemChanged: (int index) {
                    selectitem = index;
                  },
                  children: List<Widget>.generate(content.length, (int index) {
                    return Center(
                      child: Text(content[index]),
                    );
                  }),
                ),
              ),
            ],
          ) :
          CupertinoDialog(
              child: Container(
                  color: Colors.white,
                  constraints: BoxConstraints(maxHeight: heightTotal),
                  child: Scaffold(
                      appBar: AppBar(
                        elevation: 1,
                        leading: IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        title: title == null ? Container() : Text(title),
                      ),
                      body: ListView.builder(
                          itemCount: content.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop(index);
                                },
                                child: Container(
                                    color: Colors.transparent,
                                    child: Column(children: <Widget>[
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(10.0),
                                          height: heightCell,
                                          child: Text(content[index])),
                                      SizedBox(
                                          height: 1.0,
                                          child: Container(color: AppColors.GREY))
                                    ])
                                ));
                          })
                  ))
          );
        });

    return result;
  }

}
