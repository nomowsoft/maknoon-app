import 'package:maknoon/model/core/educational/educational_plan.dart';
import 'package:maknoon/model/core/enums.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/data/database_helper.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';

class EducationalPlanService {
  final ApiHelper _apiHelper = ApiHelper();
  late EducationalPlan educationalPlan;
  Future<ResponseContent> getEducationalPlan(
      int episodeId, int studentId) async {
    ResponseContent response = await _apiHelper.getV2(
        '${EndPoint.educationalPlan}?episode_id=$episodeId&student_id=$studentId',
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data = response.data != null
            ? EducationalPlan.fromJson(response.data, episodeId, studentId)
            : EducationalPlan();
        return response;
      } catch (e) {
        return ResponseContent(
            statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
      }
    } else {
      return response;
    }
  }

  Future<EducationalPlan> getEducationalPlanLocal(
      int episodeId, int studentId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allPlanLines = await dbHelper.queryAllRowsWhereTowColumns(
          DatabaseHelper.tableEducationalPlan,
          EducationalPlanColumns.episodeId.value,
          EducationalPlanColumns.studentId.value,
          episodeId,
          studentId);
      return allPlanLines
          ?.map((val) => EducationalPlan.fromJsonLocal(val))
          .toList()
          .first??EducationalPlan(episodeId: episodeId,planListen: [],planReviewSmall: [],planReviewbig: [],planTlawa: [],studentId:  studentId);
    } catch (e) {
      return EducationalPlan(episodeId: episodeId,planListen: [],planReviewSmall: [],planReviewbig: [],planTlawa: [],studentId:  studentId);
    }
  }

  Future setEducationalPlanLocal(EducationalPlan educationalPlan) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      var json = educationalPlan.toJson();
      var count = await dbHelper.queryRowCountWhereAndInteger(
          DatabaseHelper.tableEducationalPlan,
          EducationalPlanColumns.episodeId.value,
          EducationalPlanColumns.studentId.value,
          educationalPlan.episodeId,
          educationalPlan.studentId);
      if (count != null && count > 0) {
        await dbHelper.updateWhereAnd(
            DatabaseHelper.tableEducationalPlan,
            json,
            EducationalPlanColumns.episodeId.value,
            EducationalPlanColumns.studentId.value,
            educationalPlan.episodeId,
            educationalPlan.studentId);
      } else {
        await dbHelper.insert(DatabaseHelper.tableEducationalPlan, json);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllEducationalPlans() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableEducationalPlan);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteAllEducationalPlansOfEpisode(int episodeId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tableEducationalPlan,EducationalPlanColumns.episodeId.value,episodeId);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteAllEducationalPlansOfStudent(int studentId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tableEducationalPlan,EducationalPlanColumns.studentId.value,studentId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<ResponseContent> getAllMistakesPlanListen() async {
  //    late ResponseContent responseListen;
  //    for(int i =0; i< educationalPlan.planListen.length ;i++){
  //      responseListen = await PlanLinesService().getPlanLineMistakes(educationalPlan.planListen[i].prepId.toString());
  //     if(responseListen.isSuccess){
  //       educationalPlan.planListen[i].mistakes=responseListen.data;
  //     }else{
  //       break;
  //     }
  //     }
  //    return responseListen;
  // }
  // Future<ResponseContent> getAllMistakesPlanReviewbig() async {
  //    late ResponseContent responReviewbig;
  //    for(int i =0; i< educationalPlan.planReviewbig.length ;i++){
  //      responReviewbig = await PlanLinesService().getPlanLineMistakes(educationalPlan.planReviewbig[i].prepId.toString());
  //     if(responReviewbig.isSuccess){
  //       educationalPlan.planReviewbig[i].mistakes=responReviewbig.data;
  //     }else{
  //       break;
  //     }
  //     }
  //    return responReviewbig;
  // }
  // Future<ResponseContent> getAllMistakesPlanReviewSmall() async {
  //    late ResponseContent responReviewSmall;
  //    for(int i =0; i< educationalPlan.planReviewSmall.length ;i++){
  //      responReviewSmall = await PlanLinesService().getPlanLineMistakes(educationalPlan.planReviewSmall[i].prepId.toString());
  //     if(responReviewSmall.isSuccess){
  //       educationalPlan.planReviewSmall[i].mistakes=responReviewSmall.data;
  //     }else{
  //       break;
  //     }
  //     }
  //    return responReviewSmall;
  // }
  // Future<ResponseContent> getAllMistakesPlanTlawa() async {
  //    late ResponseContent responsPlanTlawa;
  //    for(int i =0; i< educationalPlan.planTlawa.length ;i++){
  //      responsPlanTlawa = await PlanLinesService().getPlanLineMistakes(educationalPlan.planTlawa[i].prepId.toString());
  //     if(responsPlanTlawa.isSuccess){
  //       educationalPlan.planTlawa[i].mistakes=responsPlanTlawa.data;
  //     }else{
  //       break;
  //     }
  //     }
  //    return responsPlanTlawa;
  // }

}
