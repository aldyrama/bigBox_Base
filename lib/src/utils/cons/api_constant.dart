import 'package:bigbox_flutter/src/helper/enumClass.dart';

///your base_url
String mockApi =  "http://private-9936c.apiary-mock.com/";
String stagingApi =  "http://";
String productionApi = "https://private-4f4db-alacarteapiary.apiary-mock.com/";

///Change this status to determine the base of the url that will run
APIState currentState = APIState.STAGING;

///this is a function for the base url
String baseUrl() {
  switch (currentState) {
    case APIState.MOCK:
      return mockApi;
    case APIState.STAGING:
      return stagingApi;
    case APIState.PRODUCTION:
      return productionApi;
  }
}

class ApiConstant {
  /// Add your enpoind this here, and global use class "ApiConstant.YOUR_ENPOIND"

  static const String signInRoot = "YOUR_ENPOIND";
}