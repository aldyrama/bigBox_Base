import 'dart:io';

import 'package:bigbox_flutter/src/utils/router/undifined_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/bloc/bigbox_bloc_delegate.dart';
import 'src/service/api_manager.dart';
import 'src/utils/cons/app_constant.dart';
import 'src/utils/router/route_config.dart';
import 'src/value/app_colors.dart';
import 'src/view/splash/splash_screen_view.dart';

void main() {
  /// BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  /// We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  /// This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = BigBoxBlocDelegate();

  runApp(BigBoxApp());
}

class BigBoxApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BigBoxAppState();
}

class BigBoxAppState extends State<BigBoxApp> {

  @override
  void initState() {
    super.initState();
    if(!kIsWeb){
      APIManager.initAPIManager(context);
      //    PushNotificationService().initialize();
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.PRIMARY_COLOR_DARK, statusBarBrightness: Brightness.dark));

    }
  }

  @override
  Widget build(BuildContext context) {
    if(kIsWeb){
      return MaterialApp(
        title: AppConstant.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "YOUR_FONT",
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreenView(),
        onGenerateRoute: RouterConfig().generateRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name,)),
      );
    }else{
      return MaterialApp(
        title: AppConstant.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "YOUR_FONT",
            primaryColor: AppColors.PRIMARY_COLOR,
            accentColor: AppColors.ACCENT_COLOR,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            pageTransitionsTheme: Platform.isAndroid && Platform.isIOS ? PageTransitionsTheme(
                builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(), TargetPlatform.iOS: CupertinoPageTransitionsBuilder()}
            ) : null
        ),
        navigatorKey: Platform.isAndroid && Platform.isIOS ? APIManager.alice.getNavigatorKey() : null,
        home: SplashScreenView(),
        onGenerateRoute: RouterConfig().generateRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name,)),
      );
    }
  }
}


