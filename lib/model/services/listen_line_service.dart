import 'package:maknoon/model/core/enums.dart';
import 'package:maknoon/model/core/listen_line.dart';
import 'package:maknoon/model/core/plan_lines/plan_line.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/core/shared/status_and_types.dart';
import 'package:maknoon/model/data/database_helper.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';
import 'dart:convert' as convert;

class ListenLineService{
 final ApiHelper _apiHelper = ApiHelper();
Future<ResponseContent> postListenLine(ListenLine listenLine) async {
    var json = listenLine.toJson();
    var data = convert.jsonEncode(json);
    ResponseContent response = await _apiHelper.postV2(EndPoint.listenLine, data,linkApi: "https://api.e-maknoon.org",
        contentType: ContentTypeHeaders.applicationJson);
    if (response.success ?? false) {
      try {
        if(response.data != null){
          response.data = ResponseDataListenLine.fromJson(response.data['line_id']);
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
Future<ResponseContent> postListenLines(List<ListenLine> listenLines) async {
    var json = listenLines.map((e) => e.toJson()).toList();
    var data = convert.jsonEncode(json);
    ResponseContent response = await _apiHelper.postV2(EndPoint.listenLines, data,linkApi: "https://api.e-maknoon.org",
        contentType: ContentTypeHeaders.applicationJson);
    if (response.success ?? false) {
      try {
        // if(response.data != null){
        //   response.data = ResponseDataListenLine.fromJson(response.data['line_id']);
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


    Future<List<ListenLine>?> getListenLinesLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allStudents = await dbHelper.queryAllRows(
          DatabaseHelper.tableListenLine);
      return allStudents
              ?.map((val) => ListenLine.fromJson(val))
              .toList() ??
          [];
    } catch (e) {
      return null;
    }
  }

  Future<int> getCountListenLinesLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final count =
          await dbHelper.queryRowCount(DatabaseHelper.tableListenLine);
      return count ?? 0;
    } catch (e) {
      return 0;
    }
  }
  
  Future setListenLineLocal(ListenLine listenLine) async {
    try {
      final dbHelper = DatabaseHelper.instance; 
        var json = listenLine.toJson();
        await dbHelper.insert(DatabaseHelper.tableListenLine, json);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllListenLineStudent() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableListenLine);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteListenLineStudent(int linkId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAllWhere(DatabaseHelper.tableListenLine,ListenLineColumns.linkId.value,linkId);
      return true;
    } catch (e) {
      return false;
    }
  }
}


class ResponseDataListenLine{
 int lineId;
 PlanLine  newStartPoint;
 ResponseDataListenLine({required this.lineId ,required this.newStartPoint});
 ResponseDataListenLine.fromJson(Map<String, dynamic> json):
    lineId = json['line_id'] ?? 0,
    newStartPoint = PlanLine.fromJson(json['new_start_point']);
}

 
