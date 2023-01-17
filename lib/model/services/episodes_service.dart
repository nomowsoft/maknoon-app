import 'package:maknoon/model/core/episodes/check_episodes_responce.dart';
import 'package:maknoon/model/core/episodes/episode.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/data/database_helper.dart';
import 'package:maknoon/model/helper/api_helper.dart';
import 'package:maknoon/model/helper/end_point.dart';
import 'package:maknoon/model/services/behaviours_service.dart';
import 'package:maknoon/model/services/educational_plan_service.dart';
import 'package:maknoon/model/services/listen_line_service.dart';
import 'package:maknoon/model/services/plan_lines_service.dart';
import 'package:maknoon/model/services/students_of_episode_service.dart';
import 'dart:convert' as convert;

import '../core/shared/status_and_types.dart';

class EdisodesService {
  final ApiHelper _apiHelper = ApiHelper();
  Future<ResponseContent> getEdisodes(
    String teacherId,
  ) async {
    ResponseContent response = await _apiHelper.getV2(
        '${EndPoint.episodes}?teacher_id=$teacherId',
        linkApi: "https://api.e-maknoon.org");
    if (response.success ?? false) {
      try {
        response.data = response.data != null
            ? (response.data as List).map((e) => Episode.fromJson(e))
            : null;
        // if (response.data != null && isSaveLocal) {
        //  // save locale
        //  await setEdisodesLocal(response.data);
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

  Future<ResponseContent> checkEpisodes(
      int teacherId, List<int> episodesIDs) async {
    var json = {"teacher_id": teacherId, "episodes": episodesIDs};
    var data = convert.jsonEncode(json);
    ResponseContent response = await _apiHelper.postV2(
        EndPoint.checkEpisodes, data,
        linkApi: "https://api.e-maknoon.org",
        contentType: ContentTypeHeaders.applicationJson);
    if (response.success ?? false) {
      try {
        response.data = response.data != null ? CheckEpisodesResponce.fromJson(response.data) : null;
        return response;
      } catch (e) {
        return ResponseContent(
            statusCode: '1', message: '#Convert-Response#\n${e.toString()}');
      }
    } else {
      return response;
    }
  }

  Future<List<Episode>?> getEdisodesLocal() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final allProducts =
          await dbHelper.queryAllRows(DatabaseHelper.tableEpisode);
      return allProducts?.map((val) => Episode.fromJson(val)).toList() ?? [];
    } catch (e) {
      return null;
    }
  }

  Future setEdisodesLocal(List<Episode> episodes) async {
    try {
      await StudentsOfEpisodeService().deleteAllStudentsState();
      await StudentsOfEpisodeService().deleteAllStudentGeneralBehavior();
      await BehavioursService().deleteAllNewBehaviourStudent();
      await ListenLineService().deleteAllListenLineStudent();
      await BehavioursService().deleteAllBehaviourTypes();
      await BehavioursService().deleteAllBehaviourStudent();
      await EducationalPlanService().deleteAllEducationalPlans();
      await PlanLinesService().deleteAllPlanLines();
      await StudentsOfEpisodeService().deleteAllStudentsOfEpisode();
      await deleteAllEdisodes();
      final dbHelper = DatabaseHelper.instance;
      for (var episode in episodes) {
        var json = episode.toJson();
        await dbHelper.insert(DatabaseHelper.tableEpisode, json);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future setEdisodeLocal(Episode episode) async {
    try {
      final dbHelper = DatabaseHelper.instance;
        var json = episode.toJson();
        await dbHelper.insert(DatabaseHelper.tableEpisode, json);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllEdisodes() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.deleteAll(DatabaseHelper.tableEpisode);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deletedEpisode(int episodeId) async {
    try {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.delete(DatabaseHelper.tableEpisode,episodeId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
