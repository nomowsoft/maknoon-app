import 'package:maknoon/model/core/enums.dart';
import 'package:maknoon/model/core/plan_lines/plan_lines.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/data/database_helper.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';

class PlanLinesService{
 final ApiHelper _apiHelper = ApiHelper();
Future<ResponseContent> getPlanLines(int episodeId,int studentId) async {
    ResponseContent response = await _apiHelper.getV2('${EndPoint.planLines}?episode_id=$episodeId&student_id=$studentId',linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data =
            response.data != null ? PlanLines.fromJson(response.data,episodeId,studentId):null;
        return response;
      } catch (e) {
        return ResponseContent(
            statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
      }
    } else {
      return response;
    }
  }
  
    Future<PlanLines?> getPlanLinesLocal(int episodeId,int studentId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allPlanLines =
          await dbHelper.queryAllRowsWhereTowColumns(DatabaseHelper.tablePlanLines,PlanLinesColumns.episodeId.value,PlanLinesColumns.studentId.value,episodeId,studentId);
      return allPlanLines?.map((val) => PlanLines.fromJsonLocal(val)).toList().first;
    } catch (e) {
      return null;
    }
  }
  
  Future setPlanLinesLocal(PlanLines planLines) async {
    try {
      final dbHelper = DatabaseHelper.instance; 
      var json = planLines.toJson();
      await dbHelper.insert(DatabaseHelper.tablePlanLines, json);
      return true;
    } catch (e) {
      return false;
    }
  }
   Future<bool> updatePlanLinesLocal(PlanLines planLines) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhereAnd(DatabaseHelper.tablePlanLines,PlanLinesColumns.episodeId.value,PlanLinesColumns.studentId.value,planLines.episodeId,planLines.studentId);
      await setPlanLinesLocal(planLines);
      return true;
    } catch (e) {
      return false;
    }
  }

 Future<bool> deleteAllPlanLines() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tablePlanLines);
      return true;
    } catch (e) {
      return false;
    }
  }
 Future<bool> deleteAllPlanLinesOfEpisode(int episodeId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tablePlanLines,PlanLinesColumns.episodeId.value,episodeId);
      return true;
    } catch (e) {
      return false;
    }
  }
 Future<bool> deleteAllPlanLinesOfStudent(int studentId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tablePlanLines,PlanLinesColumns.studentId.value,studentId);
      return true;
    } catch (e) {
      return false;
    }
  }

}