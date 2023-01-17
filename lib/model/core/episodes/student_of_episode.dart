import 'package:intl/intl.dart';
class StudentOfEpisode {
  int? age,
      branchId,
      id,
      isAbsent,
      isAbsentExcuse,
      isDely,
      isNotRead,
      periodId,
      planId,
      rate,
      sessionId,
      studentId,
      typeExamId,
      episodeId;
  String name, state, track,generalBehaviorType,stateDate;
  bool testRegister;
  StudentOfEpisode(
      {this.age,
      this.id,
      this.isAbsent,
      this.isAbsentExcuse,
      this.isDely,
      this.isNotRead,
      this.name = '',
      this.planId,
      this.rate,
      this.sessionId,
      this.state = '',
      this.studentId,
      this.periodId,
      this.branchId,
      this.typeExamId,
      this.track = '',
      this.stateDate = '',
      this.generalBehaviorType = '',
      this.testRegister = false});

  StudentOfEpisode.fromJson(Map<String, dynamic> json,int  newEpisodeId)
      : age = json['age'],
        id = json['id'],
        isAbsent = json['is_absent'] is int ? json['is_absent'] : null,
        isAbsentExcuse =
            json['is_absent_excuse'] is int ? json['is_absent_excuse'] : null,
        isDely = json['is_dely'] is int ? json['is_dely'] : null,
        isNotRead = json['is_not_read'] is int ? json['is_not_read'] : null,
        name = json['name'],
        planId = json['plan_id'] is int ? json['plan_id'] : null,
        rate = json['rate'] is int ? json['rate'] : null,
        sessionId = json['session_id'] is int ? json['session_id'] : null,
        state = json['state'],
        studentId = json['student_id'] is int ? json['student_id'] : null,
        testRegister = json['test_register']is bool ? json['test_register'] : false,
        periodId = json['period_id'] is int ? json['period_id'] : null,
        typeExamId = json['type_exam_id'] is int ? json['type_exam_id'] : null,
        generalBehaviorType =  json['general_behavior_type'] is String ? json['general_behavior_type'] : '',
        track = json['track'] == "down"
            ? "تنازلي"
            : json['track'] == "up"
                ? "تصاعدي"
                : '',
        stateDate = DateFormat('yyyy-MM-dd').format(DateTime.now()),        
        branchId = json['branch_id'] is int ? json['branch_id'] : null,
        episodeId = newEpisodeId;
    
    StudentOfEpisode.fromJsonLocal(Map<String, dynamic> json)
      : age = json['age'],
        id = json['id'],
        isAbsent = json['is_absent'] is int ? json['is_absent'] : null,
        isAbsentExcuse =
            json['is_absent_excuse'] is int ? json['is_absent_excuse'] : null,
        isDely = json['is_dely'] is int ? json['is_dely'] : null,
        isNotRead = json['is_not_read'] is int ? json['is_not_read'] : null,
        name = json['name'],
        planId = json['plan_id'] is int ? json['plan_id'] : null,
        rate = json['rate'] is int ? json['rate'] : null,
        sessionId = json['session_id'] is int ? json['session_id'] : null,
        state = json['state'],
        studentId = json['student_id'] is int ? json['student_id'] : null,
        testRegister = json['test_register'] is int ? json['test_register'] ==1 ? true : false : false,
        periodId = json['period_id'] is int ? json['period_id'] : null,
        typeExamId = json['type_exam_id'] is int ? json['type_exam_id'] : null,
        generalBehaviorType =  json['general_behavior_type'] is String ? json['general_behavior_type'] : '',
        track = json['track'] == "down"
            ? "تنازلي"
            : json['track'] == "up"
                ? "تصاعدي"
                : '',
        stateDate = json['state_date'] ,         
        branchId = json['branch_id'] is int ? json['branch_id'] : null,
        episodeId = json['episode_id'] is int ? json['episode_id'] : null;

   

  Map<String, dynamic> toJson() => {
        "age": age,
        "id": id,
        "is_absent": isAbsent,
        "is_absent_excuse": isAbsentExcuse,
        "is_dely": isDely,
        "is_not_read": isNotRead,
        "name": name,
        "plan_id": planId,
        "rate": rate,
        "session_id": sessionId,
        "state": state,
        "student_id": studentId, 
        "test_register": testRegister ? 1 : 0,
        "period_id": periodId,
        "type_exam_id": typeExamId,
        "track": track,
        "general_behavior_type": generalBehaviorType,
        "branch_id": branchId,
        "episode_id": episodeId,
        "state_date": stateDate,
      };
}
