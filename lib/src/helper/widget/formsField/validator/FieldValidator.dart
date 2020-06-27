
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class Validator{
  bool eightChars = false;
  bool specialChar = false;
  bool upperCaseChar = false;
  bool number = false;

 static FormFieldValidator<String> emailValidator({String errorMessage}){
      return (text){
        bool emailValid = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)").hasMatch(text);
       
        if(!emailValid)
         {
           errorMessage = errorMessage == null ? "This field must be in email formated" : errorMessage;
           return errorMessage;
         }
         return null;
      };
 }

static FormFieldValidator<String> numberOnlyValidator({String errorMessage}){
      return (text){
        bool isValid = RegExp(r"^[0-9]*$").hasMatch(text);
        if(!isValid)
         {
           errorMessage = errorMessage == null ? "This field only accept numeric character" : errorMessage;
           return errorMessage;
         }
         return null;
      };
 }

  static FormFieldValidator<String> qtyValidator({String errorMessage, int minLength, maxLength, minimumQuantity, String minLengthMessage}){
    return (text){
      print('text leng : ${text.length}');
      if(minLength != null && text.length < minLength)
      {
        minLengthMessage = minLengthMessage == null ? "( Min $minLength )" : minLengthMessage;
        return minLengthMessage;
      }
//      if(minLength!= null && text.length > maxLength)
//      {
//        minLengthMessage = minLengthMessage == null ? "This field too short (max length is $minLength digit)" : minLengthMessage;
//        return minLengthMessage;
//      }
      if(text == null || text == "${0}")
        {
          print('min qty : ${text} == ${000}');
          minLengthMessage = minLengthMessage == null ? "( Min $minimumQuantity )" : minLengthMessage;
          return minLengthMessage;
        }
      return null;
    };
  }

  static FormFieldValidator<String> portalCodeValidator({String errorMessage, int minLength, maxLength,String minLengthMessage}){
    return (text){
//      bool isValid = RegExp(r"^[1-9]*$").hasMatch(text);
//      bool isValid = RegExp(r"^([8])([0-9])*$").hasMatch(text);
//      if(!isValid)
//      {
//        errorMessage = errorMessage == null ? "Phone number not valid (E.g: 8xxxxxxxxxx)" : errorMessage;
//        return errorMessage;
//      }
      if(minLength!= null && text.length < minLength)
      {
        minLengthMessage = minLengthMessage == null ? "This field too short (min length is $minLength digit)" : minLengthMessage;
        return minLengthMessage;
      }
      if(minLength!= null && text.length > maxLength)
      {
        minLengthMessage = minLengthMessage == null ? "This field too short (max length is $minLength digit)" : minLengthMessage;
        return minLengthMessage;
      }
      return null;
    };
  }

  static FormFieldValidator<String> numberPhoneValidator({String errorMessage, int minLength, maxLength,String minLengthMessage}){
    return (text){
//      bool isValid = RegExp(r"^[1-9]*$").hasMatch(text);
      bool isValid = RegExp(r"^([8])([0-9])*$").hasMatch(text);
      if(!isValid)
      {
        errorMessage = errorMessage == null ? "Phone number not valid (E.g: 8xxxxxxxxxx)" : errorMessage;
        return errorMessage;
      }
      else if(minLength!= null && text.length < minLength)
      {
        minLengthMessage = minLengthMessage == null ? "This field too short (min length is $minLength digit)" : minLengthMessage;
        return minLengthMessage;
      }
      if(minLength!= null && text.length > maxLength)
      {
        minLengthMessage = minLengthMessage == null ? "This field too short (max length is $minLength digit)" : minLengthMessage;
        return minLengthMessage;
      }
      return null;
    };
  }

 static FormFieldValidator<String> textOnlyValidator({String errorMessage}){
      return (text){
        bool isValid = RegExp(r"^[a-zA-Z.]+").hasMatch(text);
        if(!isValid)
         {
           errorMessage = errorMessage == null ? "This field only accept text character" : errorMessage;
           return errorMessage;
         }
         return null;
      };
 }

static FormFieldValidator<String> passwordValidator({int minLength,String minLengthMessage,bool isUniques  =  false, String uniqueMessage}){
      return (text){
        if(minLength!= null && text.length < minLength)
         {
           minLengthMessage = minLengthMessage == null ? "Is too short (min length is $minLength)" : minLengthMessage;
           return minLengthMessage;
         }
         else if(isUniques){
             var mediumRegex = new RegExp("^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#%\$&*~^<>()]).{6,}");
//             var mediumRegex = new RegExp("^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])(?=.*?[!@#\$&*~])))");
             bool isTextUnique = true;
//             bool isTextUnique = mediumRegex.hasMatch(text);

             if(!isTextUnique){
               uniqueMessage = uniqueMessage == null ? "Too weak, add special characters and numbers" : uniqueMessage;
             }
             
             return uniqueMessage;
         }
         return null;
      };
 }

  static FormFieldValidator<String> nameValidator({int minLength,String minLengthMessage, String errorMessage, bool isUniques  =  false}){
    return (text){
      bool isValid = RegExp("[^A-Za-z\\s]+").hasMatch(text);
      if(minLength!= null && text.length < minLength)
      {
        minLengthMessage = minLengthMessage == null ? "This field is too short (min text length is $minLength)" : minLengthMessage;
        return minLengthMessage;
      }else if(isValid){
        errorMessage = errorMessage == null ? "This field only accept text character" : errorMessage;
        return errorMessage;
      }
      return null;
    };
  }

 static FormFieldValidator<String> usenameValidator({int minLength,String minLengthMessage, String errorMessage, bool isUniques  =  false}){
   return (text){
     bool isValid = RegExp(r"[^A-Za-z0-9]+").hasMatch(text);
     if(minLength!= null && text.length < minLength)
     {
       minLengthMessage = minLengthMessage == null ? "This field is too short (min text length is $minLength)" : minLengthMessage;
       return minLengthMessage;
     }else if(isValid){
       errorMessage = errorMessage == null ? "This field only accept alphanumeric character" : errorMessage;
       return errorMessage;
     }
     return null;
   };
 }

 static FormFieldValidator<String> matchingTextValidator(TextEditingController otherField,{String errorMessage}){
       return (text){
           if(otherField.text != text){
               errorMessage = errorMessage == null ? "This field is not match" : errorMessage;    
               return errorMessage;  
           }
          return null;
       };
 }

 static FormFieldValidator<String> birthdayValidator(String dateFormat,{String errorMessage}){
      return (text){
        
        DateFormat formater = DateFormat(dateFormat);
        DateTime initial;
        try {
          initial = formater.parse(text);

//           if(initial.compareTo(DateTime.now()) > 0){
           if(initial.year > DateTime.now().year - 17){
             print('datetime : ${initial.year}');
               errorMessage = errorMessage == null ? "This field must be 17 years lower than today" : errorMessage;
//               errorMessage = errorMessage == null ? "This field must be lesser than today" : errorMessage;
               return errorMessage;
           }
           
        } catch (error) {}

        return null;
      };
 }

 static FormFieldValidator<String> greaterThanTodayValidator(String dateFormat,{String errorMessage}){
      return (text){      
        DateFormat formater = DateFormat(dateFormat);
        DateTime initial;
        try {
          initial = formater.parse(text);

           if(initial.compareTo(DateTime.now()) < 0){
               errorMessage = errorMessage == null ? "This field must be greater than today" : errorMessage;    
               return errorMessage;  
           }
           
        } catch (error) {}

        return null;
      };
  }


}