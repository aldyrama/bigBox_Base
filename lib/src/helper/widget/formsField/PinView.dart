
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class PinView extends StatefulWidget{

final int pinNumber;
final bool isSecure;
final Color underlineColor;
final GlobalKey<PinViewState> key;
final Color textColor;

PinView({this.key,this.pinNumber = 4, this.isSecure = false,this.underlineColor = Colors.grey,this.textColor = Colors.black});

 @override
  State<StatefulWidget> createState() {
    return PinViewState();
  }

}


class PinViewState extends State<PinView> {

 final pinKey = GlobalKey();
 final _focusNode = FocusNode(); 
 final _textController = TextEditingController();
 String currentValue = "";

 Widget pinLabel(String text){
    
   Widget content = Text(text,style: TextStyle(fontSize: 45.0,fontStyle:FontStyle.normal,color: widget.textColor,decoration:TextDecoration.none));

   if(widget.isSecure){
       Widget iconLbl = text == " " ? Container() : Icon(Icons.adjust,color: Colors.black);
       content = SizedBox(width:35.0,height: 45.0,child:Center(child:iconLbl,));
   }

   return 
        SizedBox(width: 35.0,child:
        Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.min,children: <Widget>[
        content,
        SizedBox(height: 2.0),
        SizedBox(height: 5.0,child: Container(color: this.widget.underlineColor),)
        
   ]));

 }


Widget pinContainer(int pinNumber){
   
   List<String> characters = [];

   for (int i=0;i<max(currentValue.length,pinNumber);i++){
       if(i<currentValue.length){
          characters.add(currentValue[i]);
       }
       else{
          characters.add(" ");
       }
   }

   List<Widget> widget = characters.map((value){
     return Row(children: <Widget>[
     pinLabel(value),
     SizedBox(width: 7.0,)
     ]);
   }).toList();

   return Row(
     key: pinKey,
     crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.min,children: widget
   );

}

 Widget buildEditableText(){
   return
   Container(
   child:
    EditableText(
        focusNode: _focusNode,
        controller: _textController,
        style: TextStyle(
          color: Colors.transparent,
        ),
        cursorWidth: 0,
        cursorColor: Colors.transparent,
        backgroundCursorColor: Colors.transparent,
        inputFormatters: [BlacklistingTextInputFormatter(RegExp("[ ]"))], //ignore space
        onChanged: (newVal){
           if(newVal.length <= widget.pinNumber){
            setState(() {
              currentValue = newVal;                            
            });

            if(newVal.length == widget.pinNumber){
              FocusScope.of(context).requestFocus(new FocusNode());
            }

         }else{
            _textController.text = currentValue;
             FocusScope.of(context).requestFocus(new FocusNode());
         }
        },
      )
   );
 }


  @override
  Widget build(BuildContext context) {
    return 
    Center(child: 
     Stack(
       fit: StackFit.loose,
       children: <Widget>[
       pinContainer(widget.pinNumber),
       Positioned.fill(
         child: buildEditableText()
       )
     ]));
  }

}