part of 'index.dart';

class MyTextField extends StatefulWidget {
  final GlobalKey<MyTextFieldState> key;
  final TextEditingController controller;
  final String placeholder;
  final String prefixText;
  final String isMessage;
  final bool required;
  final bool ishintext;
  final TextInputType keyboard;
  final bool isSecure;
  final bool isApplied;
  final ValueChanged<String> onValueChanged;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final FocusNode nodes;
  final Widget image;
  final bool isEnabled;
  final bool underLines;
  final int maxl;
  final int maxLines;
  final int minLines;
  final double fontSize;
  final Color fontColor;
  final Color hintTextColor;
  final TextAlign textAlign;
  final Color enableBorderColor;
  final Color focusBorderColor;
  VoidCallback onEditingComplete;

  MyTextField(
      this.placeholder, this.controller,
      {
        this.key,
        this.required = true,
        this.ishintext = true,
        this.keyboard = TextInputType.text,
        this.isSecure = false,
        this.onValueChanged = null,
        this.onChanged = null,
        this.validator = null,
        this.nodes = null,
        this.isMessage = '',
        this.image,
        this.prefixText,
        this.isEnabled = true,
        this.underLines = true,
        this.isApplied = true,
        this.maxl,
        this.maxLines,
        this.minLines,
        this.fontSize,
        this.fontColor,
        this.hintTextColor,
        this.textAlign = TextAlign.left,
        this.enableBorderColor = AppColors.GREY3,
        this.focusBorderColor = AppColors.PRIMARY_COLOR,
        this.onEditingComplete
      });

  @override
  State<StatefulWidget> createState() {
    return MyTextFieldState();
  }
}

class MyTextFieldState extends State<MyTextField> {
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
        Flexible(
            child: Container(
              child: TextFormField(
                style: TextStyle(
                    color: widget.fontColor,
                    fontSize: widget.fontSize
                ),
                onEditingComplete: widget.onEditingComplete,
                textAlign: widget.textAlign,
                key: textFieldKey,
                decoration: widget.underLines == true ? InputDecoration(
                  labelText: widget.placeholder,
                  alignLabelWithHint: true,
                  errorText: widget.isMessage == '' ? null : widget.isMessage,
                  hintText: widget.ishintext == true ? widget.placeholder : null,
                  counterStyle: TextStyle(height: double.minPositive,),
                  counterText: "",
                  errorStyle: TextStyle(fontSize: 10),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.focusBorderColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.enableBorderColor),
                  ),
                  suffixIcon: widget.isSecure != true ? null : IconButton(
                      color: Colors.grey,
                      icon: Image.asset("assets/icons/ic_eye.png", height: 14, width: 20, color: _secureText ? AppColors.GREY3 :
                      AppColors.BLACK,),
                      onPressed: showHidePassword
                  ),
                ) :
                InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  prefixIcon: widget.image,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: AppColors.PRIMARY_COLOR,
                    style: BorderStyle.solid,
                    width: 1.5,
                    ),
                  ),
                  suffixIcon: widget.isSecure != true ? null : IconButton(
                      color: Colors.grey,
                      icon: Image.asset("assets/icons/ic_eye.png", height: 14, width: 20, color: _secureText ? AppColors.GREY3 :
                      AppColors.BLACK,),
//                      icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility,),
                      onPressed: showHidePassword
                  ),
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(color: widget.hintTextColor),
                  prefixText: widget.prefixText,
                  focusColor: AppColors.PRIMARY_COLOR,
//                  focusedBorder: OutlineInputBorder(
//                    borderSide: BorderSide(
//                      color: AppColors.PRIMARY_COLOR,
//                      style: BorderStyle.solid,
//                      width: 1.5,
//                    ),
//                  ),
//                  focusedErrorBorder: OutlineInputBorder(
//                    borderSide: BorderSide(
//                    color: AppColors.PRIMARY_COLOR,
//                    style: BorderStyle.solid,
//                    width: 1.5,
//                    ),
//                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1.5),
                  ),
                ),
                keyboardType: widget.keyboard,
                controller: widget.controller,
                focusNode: widget.nodes,
                enabled: widget.isEnabled,
                maxLength: widget.maxl,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                autocorrect: false,
                obscureText: !widget.isSecure ? widget.isSecure : _secureText,
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
                onChanged: (String value){
                  if (widget.onChanged != null) {
                    widget.onChanged(value);
                  }else{
                    return widget.onChanged("");
                  }
                },
                //if you want to use digit only
                //inputFormatters: [ WhitelistingTextInputFormatter.digitsOnly],
                onSaved: (String value) {
                  print(value);
                },
              ),
            )
        )
      ],
    );
  }
}
