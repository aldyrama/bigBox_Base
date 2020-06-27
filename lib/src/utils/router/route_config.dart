import 'package:bigbox_flutter/src/utils/router/route_name.dart';
import 'package:bigbox_flutter/src/view/home/screen/home_screen_view.dart';
import 'package:bigbox_flutter/src/view/sign_in/screen/signin_screen_view.dart';
import 'package:bigbox_flutter/src/view/splash/splash_screen_view.dart';

import 'router.dart';

class RouterConfig {
  Route<dynamic> generateRoute(RouteSettings settings) {
    /// use the argument if you want to send data to another page
    /// case ExampleRoute:
    /// return MaterialPageRoute(builder: (context) => ExamplePage(argument: getArgument));
    var argumens = settings.arguments;

    switch (settings.name) {
      case SplashRouted:
        return MaterialPageRoute(builder: (context) => SplashScreenView());
      case SignInRouted:
        return MaterialPageRoute(builder: (context) => SignInScreenView());
      case HomeRouted:
        return MaterialPageRoute(builder: (context) => HomeScreenView());
      default:
        return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name,));
    }
  }
}