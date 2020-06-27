import 'router.dart';

class AppNavigator {

   static void intentNamed(BuildContext context, String nameRouted){
    Navigator.pushNamed(context, nameRouted);
  }

  static intentNamedWithData(BuildContext context, String nameRouted, argumentClass) {
    Navigator.pushNamed(context, nameRouted, arguments: argumentClass);
  }

  static void intentNamedRemoveOldRoute(BuildContext context, String nameRouted) {
    Navigator.of(context).pushNamedAndRemoveUntil(nameRouted, (Route<dynamic> route) => false);
  }

  static void intentNamedRemoveOldRouteWithData(BuildContext context, String nameRouted, Object argumen) {
    Navigator.of(context).pushNamedAndRemoveUntil(nameRouted, (Route<dynamic> route) => false, arguments: argumen);
  }

   static intentReplacementNamedWithData(BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushReplacementNamed(context, nameRouted, arguments: argumentClass);
  }

  static void intentReplacementNamed(BuildContext context, String nameRouted){
    Navigator.pushReplacementNamed(context, nameRouted);
  }
  
}