
import 'service.dart';
import 'package:flutter/material.dart';

abstract class Repository{

  Future<String> signInService({@required BuildContext context, @required String usernameOrEmail, @required String password});

}