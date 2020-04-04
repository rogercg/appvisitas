import 'package:flutter/material.dart';

abstract class InputLogic{
  dynamic validateHardcorePassword(value, errorMsgHardcorePwd) {
    String  pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@!#$%^&+=])(?=\S+$).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if(regExp.hasMatch(value)){
      return null;
    }else{
      return errorMsgHardcorePwd;
    }
  }

  dynamic validateEmail(value, errorMsgEmail){
    String pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    RegExp regExp = new RegExp(pattern);
    if(regExp.hasMatch(value)){
      return null;
    }else{
      return errorMsgEmail;
    }
  }

  void fieldFocusChange(BuildContext context, FocusNode currentNode, FocusNode nextNode){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  void fieldFocusChangeOD(BuildContext context, String text, FocusNode currentNode, FocusNode nextNode){
    if(text.length>=1){
      currentNode.unfocus();
      FocusScope.of(context).requestFocus(nextNode);
    }
  }

  void fieldFocusChangeML(BuildContext context, String text, FocusNode currentNode, FocusNode nextNode, int maxLength){
    if(text.length>=maxLength){
      currentNode.unfocus();
      FocusScope.of(context).requestFocus(nextNode);
    }
  }

  dynamic validateInputType(String value, String errorMsgInputType, String inputTypeInfo) {
      Pattern pattern = r'[0-9]+';
      RegExp regExp   = new RegExp(pattern);
      if ( inputTypeInfo=='onlyNumber' && !regExp.hasMatch( value ) ) {
        return errorMsgInputType;
      }else if( inputTypeInfo=='onlyNumber' && (value.contains("*") || value.contains("-") || value.contains(",") || value.contains(".")) ){
        return errorMsgInputType;
      }else if ( inputTypeInfo=='onlyText' && regExp.hasMatch( value ) ) {
        return errorMsgInputType;
      }else{
        return null;
      }
  }

  dynamic validateLength(String value, int minLength, int maxLength, String errorMsgMaxLength, String errorMsgMinLength) {
    if(value.length > maxLength){
      return errorMsgMaxLength;
    }else if(value.length < minLength){
      return errorMsgMinLength;
    }else{
      return null;
    }
  }
}