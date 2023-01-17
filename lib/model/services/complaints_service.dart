import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';

class ComplaintsService{
 final ApiHelper _apiHelper = ApiHelper();

  Future<ResponseContent> addComplaints(int userId,String subject,String description) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.addComplaints}?user_id=$userId&subject=$subject&description=$description',linkApi: "https://api.e-maknoon.org");
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