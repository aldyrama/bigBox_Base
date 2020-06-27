//part of 'index.dart';
//
//import 'dart:html';
//
//import 'package:flutter/material.dart';
//
//class ImagePickers extends StatefulWidget {
//  final Function setImage;
//  final String imageUrl;
//  final File imageFile;
//
//  final double size;
//
//  ImagePickers(this.setImage, {this.imageFile,this.imageUrl, this.size});
//
//  @override
//  State<StatefulWidget> createState() {
//    return ImagePickersState();
//  }
//}
//
//class ImagePickersState extends State<ImagePickers> {
//  File imageFile;
//
//  void _getImage(BuildContext context, ImageSource source) {
//    Navigator.of(context).pop();
//    ImagePicker.pickImage(source: source,maxWidth:widget.size).then((File image) {
//      setState(() {
//        imageFile = image;
//      });
//      widget.setImage(image);
//    });
//  }
//
//  void _openImagePicker(BuildContext context) {
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context) {
//          return Container(
//            height: 190.0,
//            padding: EdgeInsets.all(10.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: [
//              Text(
//                'Pick an Image',
//                style: TextStyle(fontWeight: FontWeight.bold),
//                textAlign: TextAlign.center,
//              ),
//              SizedBox(
//                height: 5.0,
//              ),
//              Divider(),
//              SizedBox(
//                height: 5.0,
//              ),
//              FlatButton(
//                textColor: Theme.of(context).primaryColor,
//                child: Text('Use Camera',style: TextStyle(fontSize: 18.0),),
//                onPressed: () {
//                  _getImage(context, ImageSource.camera);
//                },
//              ),
//              SizedBox(
//                height: 10.0,
//              ),
//              FlatButton(
//                textColor: Theme.of(context).primaryColor,
//                child: Text('Use Gallery',style: TextStyle(fontSize: 18.0)),
//                onPressed: () {
//                  _getImage(context, ImageSource.gallery);
//                },
//              )
//            ]),
//          );
//        });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//                child: new IconButton(
//                    icon: new Icon(
//                      Icons.photo_camera,
//                      color: Theme.of(context).accentColor,
//                    ),
//                    onPressed: () {
//                      _openImagePicker(context);
//                    }),
//              );
//  }
//
//}
//
//class AvatarInput extends ImagePickers{
//
//  AvatarInput(Function setImage,{imageFile,imageUrl,size= 100.0}) : super(setImage,imageFile:imageFile,imageUrl:imageUrl,size:size);
//
//  @override
//  State<StatefulWidget> createState() {
//    return AvatarInputState();
//  }
//
//}
//
//class AvatarInputState extends ImagePickersState{
//
//@override
//  Widget build(BuildContext context) {
//    Widget previewImage =
//    new Container(
//      width: 100.0,
//      height: 100.0,
//      decoration: new BoxDecoration(
//        color: Colors.white,
//        image: new DecorationImage(
//          image: AssetImage("assets/icons/icon_user.png"),
//          fit: BoxFit.cover,
//        ),
//        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
//        border: new Border.all(
//          color: Colors.black,
//          width: 1.0,
//        ),
//      ),
//    );
////    Image.asset("assets/icons/icon_user.png", scale: 3.7,);
////        Icon(Icons.account_circle, color: Colors.grey, size: widget.size);
//    imageFile = imageFile != null ? imageFile : widget.imageFile;
//
//    if (imageFile != null) {
//      previewImage =
//      Container(width: widget.size,height: widget.size,child:
//      CircleAvatar( backgroundImage: FileImage(imageFile),backgroundColor: Colors.grey,));
//    } else if (widget.imageUrl != null) {
//      Container(width: widget.size,height: widget.size,child:
//      previewImage = CircleAvatar( backgroundImage:NetworkImage(widget.imageUrl),backgroundColor: Colors.grey));
//    }
//
//    return Column(children: <Widget>[
//      Stack(children: <Widget>[
//        previewImage,
//        GestureDetector(
//            behavior: HitTestBehavior.opaque,
//            onTap: () {
//              _openImagePicker(context);
//            },
//            child: Container(width: widget.size, height: widget.size))
//      ]),
//      SizedBox(height: 18.0,),
//      OutlineButton(onPressed: (){_openImagePicker(context);},
//          borderSide: BorderSide(
//            color: Colors.black, //Color of the border
//            style: BorderStyle.solid, //Style of the border
//            width: 1.5, //width of the border
//          ),
//      child: Padding(
//        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
//        child: Wrap(
//          crossAxisAlignment: WrapCrossAlignment.center,
//          children: <Widget>[
//            Image.asset("assets/icons/upload.png", scale: 3, alignment: Alignment.center,),
//            SizedBox(width: 14.0,),
//            Text("UPLOAD AVATAR", style: TextStyle(fontSize: 12.0, fontFamily: 'BrandonGrotesque', fontWeight: FontWeight.bold, color: Colors.black),)
//          ],
//        )
//      )),
//    ]);
//  }
//
//}
//
//
//
