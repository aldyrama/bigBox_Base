import 'package:flutter/widgets.dart';

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}

void somethingWrong(BuildContext context, FetchDataException e, void fetchData()){

  switch(e.toString()){
    case "Exception: Exception: 401" :
      {
      }
      break;
    case "Exception: Exception: 403" :
      {
      }
      break;
    case "Exception: Exception: 404" :
      {
      }
      break;
    case "Exception: Exception: 406" :
      {
      }
      break;
    case "Exception: Exception: 500" :
      {
      }
      break;
    case "Exception: Exception: 503" :
      {
      }
      break;
    case "Exception: Exception: 509" :
      {
      }
      break;
  }
}