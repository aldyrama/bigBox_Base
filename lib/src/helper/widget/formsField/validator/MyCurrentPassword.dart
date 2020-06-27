
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCurrentPassword extends StatefulWidget {
  final GlobalKey<MyCurrentPasswordState> key;
  final TextEditingController controller;
  final String placeholder;
  final bool required;
  final TextInputType keyboard;
  final bool isSecure;
  final ValueChanged<String> onValueChanged;
  final FormFieldValidator<String> validator;
  final FocusNode nodes;

  MyCurrentPassword(this.placeholder, this.controller,
      {
        this.key,
        this.required = true,
        this.keyboard = TextInputType.text,
        this.isSecure = false,
        this.onValueChanged = null,
        this.validator = null,
        this.nodes = null});

  @override
  State<StatefulWidget> createState() {
    return MyCurrentPasswordState();
  }
}

class MyCurrentPasswordState extends State<MyCurrentPassword> {
  bool isFirstTime = true;
  final textFieldKey = GlobalKey<FormFieldState<String>>();
  bool _secureText = true;
  bool isProcessing = false;

  showHidePassword() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_textListener);
  }

  @override
  void dispose() {
    // Stop listening to text changes
    widget.controller.removeListener(_textListener);
    super.dispose();
  }

  _textListener() {
    if (isFirstTime) {
      isFirstTime = false;
    }
    textFieldKey.currentState.validate();
  }

  void validate(){
    textFieldKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
            padding:
            EdgeInsets.symmetric(vertical: 10.0),
            child: Padding(padding: EdgeInsets.only(right: 8.0),
              child: Image.asset("assets/icons/icon_password.png", scale: 4,),)
        ),
        Flexible(
            child: TextFormField(
              key: textFieldKey,
              decoration: InputDecoration(labelText: widget.placeholder,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                ),
              ),
              validator: (String value) {
                value = widget.controller.text;
                if (value.isEmpty && widget.required) {
                  return widget.placeholder + ' is required';
                }

                if (widget.validator != null) {
                  return widget.validator(value);
                }
                return null;
              },
              onFieldSubmitted: (String value) {
                if (widget.onValueChanged != null) {
                  widget.onValueChanged(value);
                }
              },
              keyboardType: widget.keyboard,
              controller: widget.controller,
              focusNode: widget.nodes,
//              enabled: false,
              autocorrect: false,
              obscureText: _secureText,
              //if you want to use digit only
              //inputFormatters: [ WhitelistingTextInputFormatter.digitsOnly],
              onSaved: (String value) {
                print(value);
              },
            )
        )
      ],
    );
  }
}
