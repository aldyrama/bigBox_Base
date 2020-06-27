import 'dart:convert';

import 'package:bigbox_flutter/src/utils/cons/api_constant.dart';
import 'package:flutter/widgets.dart';
import 'service.dart';

class APIManager {
  final bool showCurl = true;
  BuildContext context;
  PublishSubject<bool> logOutSubject;

  APIManager(this.context);

  static APIManager _apiManager;

  static initAPIManager(BuildContext context){
    _apiManager = APIManager(context);
  }

  static Alice alice = Alice(showNotification: true, darkTheme: true);

  static APIManager getAPI() => _apiManager;

  static Future<Dio> getManager({bool showAlert = true}) async {
    return _apiManager._manager(showAlert:showAlert);
  }

  Future<Dio> _manager({bool showAlert = true}) async {
    BaseOptions option = await getDioOptions();
    Dio dio = Dio(option);

    dio.interceptors.add(alice.getDioInterceptor());
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options){
          /// Do something before request is sent
          String curl = "curl -k -X ${options.method} --dump-header -";

          for (String key in options.headers.keys) {
            String header = " -H \"$key: ${options.headers[key]}\"";
            curl = curl + header;
          }

          dynamic data = options.data;
          try {
            String encoding = json.encode(data);
            if (encoding != null) {
              curl = curl + " -d \"$encoding\"";
            }
          } catch (error) {
            if (showCurl) {
              if(data is String){
                print("Param:" + data);
              }
            }
          }

          if (options.path.contains("http")) {
            curl = curl + " ${options.path}";
          } else {
            curl = curl + " ${options.baseUrl}${options.path}";
          }

          if (showCurl) {
            print(curl);
          }

          return options; ///continue
        },
        onResponse:(Response response) {
          /// Do something with response data
          return response; // continue
        },
        onError: (DioError e) {
          /// Do something with response error
          /// Do something with response error
          print("error response : ${e.toString()}");
          Response response = e.response;

          if (e.response.data is Map == false) {
            e.error = "Not in JSON Format";
            if (showAlert) {
              // Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//              showOKModal(context,
//                  title: "Error", message: e.message);
            }
          } else if (context != null) {
            if (response.statusCode == 401) {
              e.error = "Access Token Expired";
//              Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//              showOKModal(context, title: "Error " + response.statusCode.toString(),
//                  message: e.message).then((value) {
//                logOutSubject?.add(true);
//              });
            } else if (response.data != null) {
              String message = response.data["message"];
              e.error = message != null ? message : "";
              if (showAlert) {
                  print("object response : $response");
//                showOKModal(context,
//                    title: "Error " + response.statusCode.toString(),
//                    message: e.message);
              }
            }
          }
          return e; ///continue

        }));

    return dio;

  }

  Future<BaseOptions> getDioOptions() async {
    Map<String, String> headers = new HashMap();
    headers['Content-Type'] = 'application/json';
    headers['x-api-key'] = '';
    BaseOptions option = BaseOptions();
    option.baseUrl = baseUrl();
    option.headers["Authorization"] = "Bearer ${await AppSharedPreferences.getToken()}";
//    option.headers["Content-Type"] = "multipart/form-data";
//    option.connectTimeout = 5000; //5s
//    option.receiveTimeout= 3000;
    option.contentType = "multipart/form-data";
    option.contentType = "application/json";
//    option.headers = headers;
    //option.extra = {"alert":"Test Extra"};

    /*
    Map<String, dynamic> auth = await getProfileDic();
    if (auth != null) {
      option.headers = {"Authorization": auth["token"]};
    }
    */
    return option;
  }
}
