import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/core/shared/status_and_types.dart';
import 'package:maknoon/model/core/user/auth_model.dart';
import 'package:maknoon/model/core/user/sgin_in.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'dart:convert' as convert;

import 'package:maknoon/model/helper/end_point.dart';
import 'package:maknoon/model/services/user_service.dart';

class AuthService{
 final ApiHelper _apiHelper = ApiHelper();
Future<ResponseContent> postSignIn(SignIn signIn) async {
    var json = signIn.toJson();
    var data = convert.jsonEncode(json);
    ResponseContent response = await _apiHelper.postV2(EndPoint.signIn, data,linkApi: "https://edu.maknon.org.sa/api",
        contentType: ContentTypeHeaders.applicationJson);
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? AuthModel.fromJson(response.data) : null;
        if (response.data != null) {
         await UserService().setUserLocal(response.data);
        }
        return response;
      } catch (e) {
        return ResponseContent(
            statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
      }
    } else {
      return response;
    }
  }


Future<ResponseContent> resetPassword(String userName) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.resetPwd}?login_as=1&register_code=$userName',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        if(response.data != null){
        ResponseContent? data = dataFromJson(response.data );
        if(data!=null){
          return data;
        }
        }
        return response;
      } catch (e) {
        return ResponseContent(
            statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
      }
    } else {
      return response;
    }
  }

  dataFromJson(Map<String, dynamic> jsonMap,){
    if(jsonMap['success'] == 0 && jsonMap['data'] != null){
    if(jsonMap['data'] is Map){  
    var data = Data.fromJson(jsonMap['data']);
    return ResponseContent(message: data.msg,statusCode:data.msg.isNotEmpty? '400':'200',success: data.msg.isEmpty);
    }
    }
  }
  }


class Data{
 String msg;
 int? sessionId;
 Data.fromJson(Map<String, dynamic> json):
    msg = (json['result'] is String ) ?  json['result']: '',
    sessionId = (json['session_id'] is int) ?  json['session_id'] : null;
}