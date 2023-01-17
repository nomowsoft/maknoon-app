import 'package:maknoon/model/core/behaviour/behaviour.dart';
import 'package:maknoon/model/core/enums.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/data/database_helper.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';

class BehavioursService {
  final ApiHelper _apiHelper = ApiHelper();
  Future<ResponseContent> getBehaviours() async {
    ResponseContent response = await _apiHelper.getV2(EndPoint.behaviors,
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data = response.data != null
            ? (response.data as List).map((e) => Behaviour.fromJson(e))
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

  String fromJson(Map<String, dynamic> json) {
    return json['comment_name'];
  }

  Future<ResponseContent> getBehavioursOfStudent(String linkId) async {
    ResponseContent response = await _apiHelper.getV2(
        '${EndPoint.behaviorsOfStudent}?link_id=$linkId',
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data = response.data != null
            ? (response.data['data'] as List)
                .map((e) => e['comment_name'])
                .toList()
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
 
  Future<ResponseContent> addNewBehaviour(
      int planId, int behaviorId, bool sendToParent, bool sendToTeacher) async {
    ResponseContent response = await _apiHelper.getV2(
        '${EndPoint.setBehaviourOfStudent}?plan_id=$planId&behavior_id=$behaviorId&send_to_parent=$sendToParent&send_to_teacher=$sendToTeacher',
        linkApi: "https://api.e-maknoon.org");
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

  Future<List<Behaviour>?> getBehaviourTypesLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents =
          await dbHelper.queryAllRows(DatabaseHelper.tableBehaviourTypes);
      return allStudents?.map((val) => Behaviour.fromJson(val)).toList() ?? [];
    } catch (e) {
      return null;
    }
  }

  Future setBehaviourTypesLocal(List<Behaviour> behaviours) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      for (var student in behaviours) {
        var json = student.toJson();
        await dbHelper.insert(DatabaseHelper.tableBehaviourTypes, json);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllBehaviourTypes() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableBehaviourTypes);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<BehaviourStudent>?> getBehavioursStudentLocal(int linkId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents = await dbHelper.queryAllRowsWhere(
          DatabaseHelper.tableBehaviours, BehavioursColumns.linkId.value, linkId);
      return allStudents
              ?.map((val) => BehaviourStudent.fromJson(val))
              .toList() ??
          [];
    } catch (e) {
      return null;
    }
  }

  Future setBehavioursStudentLocal(List<BehaviourStudent> behaviours) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      for (var student in behaviours) {
        var json = student.toJson();
        await dbHelper.insert(DatabaseHelper.tableBehaviours, json);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  Future setNewBehaviourStudentToBehavioursLocal(BehaviourStudent behaviour) async {
    try {
      final dbHelper = DatabaseHelper.instance;
        var json = behaviour.toJson();
        await dbHelper.insert(DatabaseHelper.tableBehaviours, json);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllBehaviourStudent() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableBehaviours);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteBehavioursStudent(int linkId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tableBehaviours,BehavioursColumns.linkId.value,linkId);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<List<NewBehaviour>?> getNewBehaviourLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents = await dbHelper.queryAllRows(
          DatabaseHelper.tableNewBehaviours);
      return allStudents
              ?.map((val) => NewBehaviour.fromJson(val))
              .toList() ??
          [];
    } catch (e) {
      return null;
    }
  }
  
  Future setNewBehaviourLocal(NewBehaviour behaviour,int linkId,String name) async {
    try {
      final dbHelper = DatabaseHelper.instance; 
        var json = behaviour.toJson();
        await dbHelper.insert(DatabaseHelper.tableNewBehaviours, json);
        await setNewBehaviourStudentToBehavioursLocal(BehaviourStudent(linkId: linkId,
        name:name));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> getCountNewBehaviourLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final count =
          await dbHelper.queryRowCount(DatabaseHelper.tableNewBehaviours);
      return count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> deleteAllNewBehaviourStudent() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableNewBehaviours);
      return true;
    } catch (e) {
      return false;
    }
  }
}
