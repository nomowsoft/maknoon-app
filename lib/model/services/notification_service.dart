import 'package:maknoon/model/core/notification/notification_model.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';

class NotificationService{
 final ApiHelper _apiHelper = ApiHelper();
Future<ResponseContent> getNotification(String teacherId) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.notifications}?teacher_id=$teacherId',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? (response.data as List).map((e) => NotificationModel.fromJson(e)) : null;
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

  Future<ResponseContent> consultNotification(int notifId) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.consultNotif}?notif_id=$notifId',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
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