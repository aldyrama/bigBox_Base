import 'package:bigbox_flutter/src/value/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

Future showOKModal(BuildContext context,
    {
      String type = "none",
      String title = "",
      String message = "",
      String images = "",
      Function onSubmit = null,
      Function onSubmitGalery = null,
      Function onSubmitCam = null,
      bool doCallbackBeforePop = true,
      bool isDismissable = true
    }) async {

  return showSimpleModal(
      context,title: title,message: message, images: images, type: type, onSubmit: onSubmit,
      onSubmitCam: onSubmitCam, onSubmitGalery: onSubmitGalery,doCallbackBeforePop: doCallbackBeforePop,
      isCancel: false,isDismissable: isDismissable);

}

Size getSizeOfContext(BuildContext context){
 return MediaQuery.of(context).size;
}

Future showSimpleModal(BuildContext context,
    {
      String type = "none",
      String title = "",
      String message = "",
      String images = "",
      String cancelTitle = "Cancel",
      String submitTitle = "OK",
      bool isCancel = true,
      Function onCancel = null,
      Function onSubmit = null,
      Function onSubmitGalery = null,
      Function onSubmitCam = null,
      bool doCallbackBeforePop = true,
      bool isDismissable = true
    }) async {

  if(context == null){
    return null;
  }

  Widget submitButton = InkWell(
      onTap: () async{
        if (onSubmit != null) {
          if (doCallbackBeforePop) {
            await onSubmit();
          }
          await Navigator.of(context).pop();
          if (!doCallbackBeforePop) {
            await onSubmit();
          }
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        child: Text(submitTitle, style: TextStyle(color: AppColors.PRIMARY_COLOR),),
      )
  );

//  Widget submitButton = Container(
//    child: RaisedButton(
//      color: Color(0xFFED8180),
//      child: Text(submitTitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//      onPressed: () async {
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
//    ),
//  );

//  Widget cancelButton = RaisedButton(
//    child: Text(cancelTitle),
//    onPressed: () async {
//      if (onCancel != null) {
//        await onCancel();
//      }
//      await Navigator.of(context).pop();
//    },
//  );

  Widget cancelButton = InkWell(
    onTap: () async{
      if (onCancel != null) {
        await onCancel();
      }
      await Navigator.of(context).pop();
    },
    child: Container(
      height: 50,
      padding: EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      child: Text(cancelTitle, style: TextStyle(color: AppColors.PRIMARY_COLOR),),
    )
  );

  List<Widget> widgetList = [submitButton];
  if (isCancel) {
    widgetList.add(cancelButton);
  }

  Widget _basic(){
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: images.isNotEmpty ? Image.asset(images) : null,
            ),
            Text(title, style: TextStyle(fontSize: 18.0, color: AppColors.PRIMARY_COLOR, fontWeight: FontWeight.w500
            ), textAlign: TextAlign.left),
            SizedBox(height: 20,),
            message == null ? Container(
              height: 1.0,
            ) : Text(message, style: TextStyle(fontSize: 16.0,), textAlign: TextAlign.left),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  onCancel != null ?
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 35.0,
                      child: cancelButton
                  ) : Container(),
                  SizedBox(width: 10,),
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 35.0,
                      child: submitButton
                  )
                ],
              ),
            )
            //            actions: widgetList,
          ],
        )
    );
  }

  Widget _buildIcClose(){
    return Positioned(
        top: 5,
        right: 5,
        child: IconButton(
            icon: Icon(Icons.close, color: AppColors.PRIMARY_COLOR,),
            onPressed: () => Navigator.pop(context)
        )
    );
  }

  Widget _buildButtonInstalNetspay(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 40,
            child: RaisedButton(
              padding: EdgeInsets.only(left: 30, right: 30),
              color: AppColors.PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(14.0),
              ),
              child: Text("Install NETSPay", style: TextStyle(
                  color: AppColors.WHITE),),
              onPressed: onSubmit,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton(){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: new BorderRadius.all(Radius.circular(14))
                  ),
                  child: Text("Cancel", style: TextStyle(color: AppColors.PRIMARY_COLOR),),
                ),
              )
          ),
          SizedBox(width: 10,),
          Expanded(
              child: Container(
                height: 35,
                child: RaisedButton(
                  color: AppColors.PRIMARY_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(14.0),
                  ),
                  child: Text("Log out", style: TextStyle(
                      color: AppColors.WHITE),),
                  onPressed: onSubmit,
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text("Going somewhere?"),
          SizedBox(height: 30,),
          _buildButton(),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget _buildNetspayMessage(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text("Please install NETSPay"),
          SizedBox(height: 30,),
          _buildButtonInstalNetspay(),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget _buildDefaultMessage(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message),
        ],
      ),
    );
  }

  ///logout
  Widget _logOut(){
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(17.0))
      ),
      content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 170,
                decoration: new BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: new BorderRadius.all(Radius.circular(17))
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    _buildMessage(),
                    _buildIcClose()
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  Widget _buildListTakeimage(){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: onSubmitCam,
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("User Camera"),
                  SizedBox(height: 10,),
                  Divider(height: 1, color: AppColors.GREY3,)
                ],
              ),
            )
          ),
          InkWell(
            onTap: onSubmitGalery,
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("From Gallery"),
                  SizedBox(height: 10,),
                  Divider(height: 1, color: AppColors.GREY3,)
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  ///logout
  Widget _takeImage(){
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(17.0))
      ),
      content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 170,
                decoration: new BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: new BorderRadius.all(Radius.circular(17))
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    _buildListTakeimage(),
                    _buildIcClose()
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  Widget _fillInput(){
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(17.0))
      ),
      content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 170,
                decoration: new BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: new BorderRadius.all(Radius.circular(17))
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    _buildDefaultMessage(),
                    _buildIcClose()
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  ///netspay
  Widget _netspay(){
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(17.0))
      ),
      content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 170,
                decoration: new BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: new BorderRadius.all(Radius.circular(17))
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    _buildNetspayMessage(),
                    _buildIcClose()
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  Widget _basicDialog(){
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(17.0))
      ),
      content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 120,
                decoration: new BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: new BorderRadius.all(Radius.circular(17))
                ),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(message),
                        ],
                      ),
                    ),
                    _buildIcClose()
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

 return showDialog(
    context: context,
    barrierDismissible: isDismissable,
    builder: (BuildContext context) {
      print("type : $type");
      if(type == "none"){
        return _basic();
      }else if(type == "logout"){
        return _logOut();
      }else if(type == "takeimage"){
        return _takeImage();
      }else if(type == "fillInput"){
        return _fillInput();
      }else if(type == "netspay"){
        return _netspay();
      }else if(type == "basic"){
        return _basicDialog();
      }
      return null;
    },
  );
}
