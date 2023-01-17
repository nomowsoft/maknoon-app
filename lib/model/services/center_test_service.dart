import 'package:maknoon/model/core/center_test/center_prepar_type.dart';
import 'package:maknoon/model/core/center_test/test_branch.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';


class CenterTestService{
 final ApiHelper _apiHelper = ApiHelper();

  Future<ResponseContent> getCenterPreparTypes(int centerPreprationId) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.centerPreparTypeTest}?center_prepration_id=$centerPreprationId',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? (response.data as List).map((e) => CenterPreparType.fromJson(e)) : null;
        if (response.data != null) {
         // save locale
        // await UserService().setUserLocal(response.data);
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

  Future<ResponseContent> getTestBranches(int testId,String trackk) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.testBranches}?test_id=$testId&trackk=$trackk',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? (response.data as List).map((e) => TestBranch.fromJson(e)) : null;
        if (response.data != null) {
         // save locale
        // await UserService().setUserLocal(response.data);
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

  Future<ResponseContent> addStudentTestSession(int studentId,int branchId,int testNameId,int testTimeId,String trackk) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.addStudentTestSession}?student_id=$studentId&branch_id=$branchId&test_name_id=$testNameId&test_time_id=$testTimeId&trackk=$trackk',linkApi: "https://api.e-maknoon.org");
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
    return ResponseContent(message: data.msg,statusCode:data.sessionId == null? '400':'200',success: data.sessionId != null);
    }
    }
  }
  
  
  Future<ResponseContent> cancelStudentTestSession(int sessionId) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.cancelStudentTestSession}?session_id=$sessionId',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
         if(response.data != null){
        ResponseContent? data = dataFromJson(response.data);
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
}

class Data{
 String msg;
 int? sessionId;
 Data.fromJson(Map<String, dynamic> json):
    msg = (json['msg'] is String ) ?  json['msg']: '',
    sessionId = (json['session_id'] is int) ?  json['session_id'] : null;
}