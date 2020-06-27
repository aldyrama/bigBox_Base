
import 'package:flutter/material.dart';

import 'service.dart';

class ApiService extends Repository {
  ///initializ dio
  Dio manager;

  @override
  Future<String> signInService({BuildContext context, String usernameOrEmail, String password}) async {
    // TODO: implement signInService
    /// this is for initializ context
    await APIManager.initAPIManager(context);
    /// this is to set an active warning when calling API
    manager = await APIManager.getManager(showAlert: true);
    /// this is call API and get response
    Response response = await manager.post(ApiConstant.signInRoot);
    final data = response.data;
    /// this is for return response
    return data;

  }

}