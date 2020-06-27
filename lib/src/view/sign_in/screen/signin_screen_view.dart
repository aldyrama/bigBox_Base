
import 'package:bigbox_flutter/src/utils/router/router.dart';
import 'package:bigbox_flutter/src/value/app_colors.dart';

class SignInScreenView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInScreenViewState();
}

class _SignInScreenViewState extends State<SignInScreenView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.PRIMARY_COLOR,
        ),
    );
  }

}