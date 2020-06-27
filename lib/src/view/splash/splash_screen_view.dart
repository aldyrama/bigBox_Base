import 'dart:async';

import 'package:bigbox_flutter/src/utils/router/app_navigator.dart';
import 'package:bigbox_flutter/src/utils/router/route_name.dart';
import 'package:bigbox_flutter/src/utils/router/router.dart';
import 'package:bigbox_flutter/src/value/app_colors.dart';

class SplashScreenView extends StatefulWidget{

  @override
  _SplashViewState createState() => _SplashViewState();

}

class _SplashViewState extends State<SplashScreenView>{

  @override
  void initState() {
    super.initState();
    _redirectView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.WHITE,
        body: _buildContent()
      ),
    );
  }

  Widget _buildContent(){
    return Container(
      alignment: Alignment.center,
      child: Image.asset("assets/Icon_512.png"),
    );
  }

  _navigator() async{
    AppNavigator.intentNamed(context, HomeRouted);
  }

  _redirectView() => Timer(Duration(seconds: 3), _navigator);
}
