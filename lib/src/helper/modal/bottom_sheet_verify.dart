
import 'package:bigbox_flutter/src/value/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

Future showBottomSheetVerify(BuildContext context,
    {String title = "",
      String message = "",
      String images = "",
      String submitTitle = "OK",
      Function onOK = null,
      bool doCallbackBeforePop = true,
      bool showButton = true,
      bool isDismissable = true}) async {

  return showSimpleModal(context,title: title,message: message, images: images, submitTitle: submitTitle,
      onSubmit: onOK,doCallbackBeforePop: doCallbackBeforePop,isCancel: false,isDismissable: isDismissable,
      showButton: showButton);

}

Future showSimpleModal(BuildContext context,
    {String title = "",
      String message = "",
      String images = "",
      String cancelTitle = "Cancel",
      String submitTitle = "OK",
      bool isCancel = true,
      bool showButton = true,
      Function onCancel = null,
      Function onSubmit = null,
      bool doCallbackBeforePop = true,
      bool isDismissable = true}) async {

  if(context == null){
    return null;
  }

//  Widget submitButton = InkWell(
//      onTap: () async{
//        if (onSubmit != null) {
//          if (doCallbackBeforePop) {
//            await onSubmit();
//          }
//          await Navigator.of(context).pop();
//          if (!doCallbackBeforePop) {
//            await onSubmit();
//          }
//        } else {
//          Navigator.of(context).pop();
//        }
//      },
//      child: Container(
//        height: 50,
//        padding: EdgeInsets.only(left: 10, right: 10),
//        alignment: Alignment.center,
//        child: Text(submitTitle, style: TextStyle(color: AppColors.PRIMARY_COLOR),),
//      )
//  );

  Widget _cancelButton(){
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 45,
        width: 210,
        alignment: Alignment.center,
        child: Text(submitTitle,
          style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 16, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget _submitButton(){
    return Container(
      height: 45,
      width: 210,
      margin: EdgeInsets.only(top: 35, bottom: 20),
      child: RaisedButton(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: AppColors.PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(14.0),
          ),
          child: Text(submitTitle,
            style: TextStyle(color: AppColors.WHITE, fontSize: 16, fontWeight: FontWeight.bold),),
          onPressed: onSubmit
      ),
    );
  }

  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(17.0),
            topRight: const Radius.circular(17.0)
        )
      ),
      context: context, builder: (BuildContext bc){
        return Container(
          child: Wrap(alignment: WrapAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(height: 5, width: 70,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.GREY,
                        borderRadius: new BorderRadius.all(Radius.circular(3))
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(title, style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text(message,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: showButton ? _submitButton() :
                    Container(height: 70,),
                  ),
//                  _cancelButton(),
                  SizedBox(height: 15,)
                ],
              )
            ],
         )
     );
  });
}
