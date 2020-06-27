
import 'package:bigbox_flutter/src/helper/responsive_layout.dart';
import 'package:bigbox_flutter/src/helper/widget/formsField/index.dart';
import 'package:bigbox_flutter/src/utils/router/router.dart';

import 'sendbtn.dart';


class Search extends StatelessWidget {
  final _exampleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.0,
        right: ResponsiveLayout.isSmallScreen(context) ? 4 : 74,
        top: 10,
        bottom: 40,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 8,
                  child: MyTextField(
                    "Your email address",
                    _exampleTextController,
                  )),
              Expanded(
                flex: 2,
                child: SendBtn(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
