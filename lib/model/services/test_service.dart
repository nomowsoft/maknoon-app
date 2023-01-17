import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/core/test/calendar_center.dart';
import 'package:maknoon/model/core/test/period.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';

import '../core/test/center.dart';

class TestService{
 final ApiHelper _apiHelper = ApiHelper();
Future<ResponseContent> getPeriods() async {
    ResponseContent response = await _apiHelper.getV2(EndPoint.periods,linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? (response.data as List).map((e) => Period.fromJson(e)) : null;
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

  Future<ResponseContent> getCenters(String gender,int episodeId ,int userId) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.centers}?gender=$gender&episode_id=$episodeId&user_id=$userId',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? (response.data as List).map((e) => Center.fromJson(e)) : null;
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

  Future<ResponseContent> getCalendarCenter(String gender,int centerId,int episodeId ,int periodId,int userId) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.calendarCenter}?gender=$gender&center_id=$centerId&episode_id=$episodeId&period_id=$periodId&user_id=$userId',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? (response.data as List).map((e) => CalendarCenter.fromJson(e)) : null;
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
}