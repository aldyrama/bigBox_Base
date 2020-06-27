part of 'index.dart';

class MyTextFieldPassword extends StatefulWidget {
  final GlobalKey<MyTextFieldPasswordState> key;
  final TextEditingController controller;
  final String placeholder;
  final bool required;
  final TextInputType keyboard;
  final bool isSecure;
  final ValueChanged<String> onValueChanged;
  final FormFieldValidator<String> validator;
  final FocusNode nodes;
  final TextAlign textAlign;
  final bool underLines;
  final String isMessage;
  final Widget image;
  final Color hintTextColor;
  final double fontSize;
  final Color fontColor;

  MyTextFieldPassword(this.placeholder, this.controller,
      {
        this.key,
        this.required = true,
        this.keyboard = TextInputType.text,
        this.isSecure = false,
        this.onValueChanged = null,
        this.validator = null,
        this.nodes = null,
        this.textAlign,
        this.underLines,
        this.isMessage,
        this.image,
        this.hintTextColor,
        this.fontColor,
        this.fontSize
      });

  @override
  State<StatefulWidget> createState() {
    return MyTextFieldPasswordState();
  }
}

class MyTextFieldPasswordState extends State<MyTextFieldPassword> {
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
    return TextFormField(
      key: textFieldKey,
      style: TextStyle(
          color: widget.fontColor,
          fontSize: widget.fontSize
      ),
      decoration: widget.underLines == true ? InputDecoration(
        errorText: widget.isMessage == '' ? null : widget.isMessage,
        hintText: widget.placeholder,
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        errorStyle: TextStyle(fontSize: 10),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC4C4C4)),
        ),
      ) :
      InputDecoration(
        prefixIcon: widget.image,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.PRIMARY_COLOR,
            style: BorderStyle.solid,
            width: 1.5,
          ),
        ),
        hintText: widget.placeholder,
        hintStyle: TextStyle(color: widget.hintTextColor),
        focusColor: AppColors.PRIMARY_COLOR,
//        focusedBorder: OutlineInputBorder(
//          borderSide: BorderSide(
//            color: AppColors.PRIMARY_COLOR,
//            style: BorderStyle.solid,
//            width: 1.5,
//          ),
//        ),
//        focusedErrorBorder: OutlineInputBorder(
//          borderSide: BorderSide(
//            color: AppColors.PRIMARY_COLOR,
//            style: BorderStyle.solid,
//            width: 1.5,
//          ),
//        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1.5),
        ),
      ),
      textAlign: widget.textAlign,
      keyboardType: widget.keyboard,
      controller: widget.controller,
      focusNode: widget.nodes,
      autocorrect: false,
      obscureText: widget.isSecure,
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
      //if you want to use digit only
      //inputFormatters: [ WhitelistingTextInputFormatter.digitsOnly],
      onSaved: (String value) {
        print(value);
      },
    );
  }
}
