import 'package:maknoon/model/core/behaviour/student_general_behavior.dart';
import 'package:maknoon/model/core/enums.dart';
import 'package:maknoon/model/core/episodes/check_students_responce.dart';
import 'package:maknoon/model/core/episodes/student_of_episode.dart';
import 'package:maknoon/model/core/episodes/student_state.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/core/shared/status_and_types.dart';
import 'package:maknoon/model/data/database_helper.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';
import 'package:intl/intl.dart';
import 'center_test_service.dart';
import 'dart:convert' as convert;

class StudentsOfEpisodeService {
  final ApiHelper _apiHelper = ApiHelper();
  Future<ResponseContent> getStudentsOfEpisode(String episodeId) async {
    ResponseContent response = await _apiHelper.getV2(
        '${EndPoint.studentsOfepisode}?episode_id=$episodeId&filter=age',
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data = response.data != null
            ? ((response.data['order_students']) as List)
                .map((e) => StudentOfEpisode.fromJson(e, int.parse(episodeId)))
            : null;
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

    Future<ResponseContent> checkStudents(
      int episodeId, List<int> linksIDs) async {
    var json = {"episode_id": episodeId, "links": linksIDs};
    var data = convert.jsonEncode(json);
    ResponseContent response = await _apiHelper.postV2(
        EndPoint.checkStudents, data,
        linkApi: "https://api.e-maknoon.org",
        contentType: ContentTypeHeaders.applicationJson);
    if (response.success ?? false) {
      try {
        response.data = response.data != null ? CheckStudentsResponce.fromJson(response.data,episodeId) : null;
        return response;
      } catch (e) {
        return ResponseContent(
            statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
      }
    } else {
      return response;
    }
  }

  Future<List<StudentOfEpisode>?> getStudentsOfEpisodeLocal(
      int episodeId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents = await dbHelper.queryAllRowsWhere(
          DatabaseHelper.tableStudentOfEpisode,
          StudentOfEpisodeColumns.episodeId.value,
          episodeId);
      return allStudents
              ?.map((val) => StudentOfEpisode.fromJsonLocal(val))
              .toList() ??
          [];
    } catch (e) {
      return null;
    }
  }

  Future<StudentOfEpisode?> getStudentLocal(
      int episodeId,int id) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents = await dbHelper.queryAllRowsWhereTowColumns(
          DatabaseHelper.tableStudentOfEpisode,
          StudentOfEpisodeColumns.episodeId.value,
          StudentOfEpisodeColumns.id.value,
          episodeId,
          id);
      return allStudents
              ?.map((val) => StudentOfEpisode.fromJsonLocal(val))
              .toList().first;
    } catch (e) {
      return null;
    }
  }

  Future setStudentsOfEpisodeLocal(
      List<StudentOfEpisode> studentEpisodes) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      for (var student in studentEpisodes) {
        var json = student.toJson();
        await dbHelper.insert(DatabaseHelper.tableStudentOfEpisode, json);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  Future updateStudentsOfEpisodeLocal(
        StudentOfEpisode studentEpisode) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      var json = studentEpisode.toJson();
      await dbHelper.update(
            DatabaseHelper.tableStudentOfEpisode,
            json);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllStudentsOfEpisode() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableStudentOfEpisode);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteStudentsOfEpisode(int episodeId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tableStudentOfEpisode,StudentOfEpisodeColumns.episodeId.value,episodeId);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteStudent(int id) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tableStudentOfEpisode,StudentOfEpisodeColumns.id.value,id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ResponseContent> setAttendance(int planId, String filter) async {
    ResponseContent response = await _apiHelper.getV2(
        '${EndPoint.setAttendance}?plan_id=$planId&filter=$filter',
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        if (response.data != null) {
          ResponseContent? data = dataFromJson(response.data);
          if (data != null) {
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
  Future<ResponseContent> setAllAttendance(List<StudentState> studentState) async {
    var json = studentState.map((e) => e.toJson()).toList();
    var data = convert.jsonEncode(json);
    ResponseContent response = await _apiHelper.postV2(
        EndPoint.setAllAttendance,data,
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        // if (response.data != null) {
        //   ResponseContent? data = dataFromJson(response.data);
        //   if (data != null) {
        //     return data;
        //   }
        // }
        return response;
      } catch (e) {
        return ResponseContent(
            statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
      }
    } else {
      return response;
    }
  }

  Future<List<StudentState>?> getStudentsStateLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudentsState =
          await dbHelper.queryAllRows(DatabaseHelper.tableStudentState);
      return allStudentsState
              ?.map((val) => StudentState.fromJson(val))
              .toList() ??
          [];
    } catch (e) {
      return null;
    }
  }
  Future<StudentState?> getStudentStateToDayLocal(int planId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudentsState =
          await dbHelper.queryAllRowsWhereTowColumns(DatabaseHelper.tableStudentState,StudentStateColumns.planId.value,StudentStateColumns.date.value, planId,DateFormat('yyyy-MM-dd').format(DateTime.now()));
      return (allStudentsState?.isNotEmpty ??false) ? allStudentsState
              ?.map((val) => StudentState.fromJson(val))
              .toList().first:null;
    } catch (e) {
      return null;
    }
  }

  Future<int> getCountStudentStateLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final count =
          await dbHelper.queryRowCount(DatabaseHelper.tableStudentState);
      return count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future setStudentStateLocal(
      StudentState studentsState) async {
    try {
      final dbHelper = DatabaseHelper.instance;
        var json = studentsState.toJsonLocal();
        var count = await dbHelper.queryRowCountWhereAnd(DatabaseHelper.tableStudentState,StudentStateColumns.planId.value,StudentStateColumns.date.value,studentsState.planId, studentsState.date);
        if(count !=null && count > 0){
        await dbHelper.deleteAllWhereAnd(DatabaseHelper.tableStudentState,StudentStateColumns.planId.value,StudentStateColumns.date.value,studentsState.planId, studentsState.date);
        }
       await dbHelper.insert(DatabaseHelper.tableStudentState, json); 
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllStudentsState() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableStudentState);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteStudentStateOfEp(int studentId,) async {
    try {
      final dbHelper = DatabaseHelper.instance;
       await dbHelper.deleteAllWhere(DatabaseHelper.tableStudentState,StudentStateColumns.studentId.value,studentId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ResponseContent> setGeneralBehavior(
      int linkId, String generalBehavior) async {
    ResponseContent response = await _apiHelper.postV2(
        '${EndPoint.setGeneralBehavior}?link_id=$linkId&general_behavior=$generalBehavior',
        '',
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        if (response.data != null) {
          ResponseContent? data = dataFromJson(response.data);
          if (data != null) {
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

  dataFromJson(
    Map<String, dynamic> jsonMap,
  ) {
    if (jsonMap['success'] == 0 && jsonMap['data'] != null) {
      if (jsonMap['data'] is Map) {
        var data = Data.fromJson(jsonMap['data']);
        return ResponseContent(
            message: data.msg,
            statusCode: data.sessionId == null ? '400' : '200',
            success: data.sessionId != null);
      }
    }
  }


   Future<List<StudentGeneralBehavior>?> getGeneralBehaviorsLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents = await dbHelper.queryAllRows(
          DatabaseHelper.tableStudentGeneralBehavior);
      return allStudents
              ?.map((val) => StudentGeneralBehavior.fromJson(val))
              .toList() ??
          [];
    } catch (e) {
      return null;
    }
  }

  Future<int> getCountGeneralBehaviorsLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final count =
          await dbHelper.queryRowCount(DatabaseHelper.tableStudentGeneralBehavior);
      return count ?? 0;
    } catch (e) {
      return 0;
    }
  }
  Future<StudentGeneralBehavior?> getStudentGeneralBehaviorLocal(int studentId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents = await dbHelper.queryAllRowsWhere(
          DatabaseHelper.tableStudentGeneralBehavior, StudentGeneralBehaviorColumns.studentId.value, studentId);
      return (allStudents?.isNotEmpty ??false) ? allStudents
              ?.map((val) => StudentGeneralBehavior.fromJson(val))
              .toList().first:null;  
    } catch (e) {
      return null;
    }
  }

 Future setStudentGeneralBehaviorLocal(
      StudentGeneralBehavior generalBehavior) async {
    try {
      final dbHelper = DatabaseHelper.instance;
        var json = generalBehavior.toJsonLocal();
        var count = await dbHelper.queryRowCountWhere(DatabaseHelper.tableStudentGeneralBehavior,StudentGeneralBehaviorColumns.studentId.value,generalBehavior.studentId);
        if(count !=null && count > 0){
        await dbHelper.deleteAllWhere(DatabaseHelper.tableStudentGeneralBehavior,StudentGeneralBehaviorColumns.studentId.value,generalBehavior.studentId);
        }
       await dbHelper.insert(DatabaseHelper.tableStudentGeneralBehavior, json); 
      return true;
    } catch (e) {
      return false;
    }
  }
  

  Future<bool> deleteAllStudentGeneralBehavior() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableStudentGeneralBehavior);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteStudentGeneralBehavior(int studentId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tableStudentGeneralBehavior,StudentGeneralBehaviorColumns.studentId.value,studentId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
