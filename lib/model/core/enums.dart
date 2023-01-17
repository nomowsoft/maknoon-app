

enum EpisodeColumns {
  id,
  displayName,
  epsdType,
  epsdWork,
  name,
}

extension MyEnumEpisodeColumns on EpisodeColumns {
  String get value {
    switch (this) {
      case EpisodeColumns.id:
        return "id";
      case EpisodeColumns.displayName:
        return "display_name";
      case EpisodeColumns.epsdType:
        return "epsd_type";
      case EpisodeColumns.epsdWork:
        return "epsd_work";
      case EpisodeColumns.name:
        return "name";
      default:
        return "";
    }
  }
}
enum StudentOfEpisodeColumns {
      age,
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
      name, 
      state,
      generalBehaviorType,
      track,
      testRegister,
      episodeId,
      stateDate
} 

extension MyEnumStudentOfEpisodeColumns on StudentOfEpisodeColumns {
  String get value {
    switch (this) {
      case StudentOfEpisodeColumns.age:
        return "age";
      case StudentOfEpisodeColumns.branchId:
        return "branch_id";
      case StudentOfEpisodeColumns.id:
        return "id";
      case StudentOfEpisodeColumns.isAbsent:
        return "is_absent";
      case StudentOfEpisodeColumns.isAbsentExcuse:
        return "is_absent_excuse";
      case StudentOfEpisodeColumns.isDely:
        return "is_dely";
      case StudentOfEpisodeColumns.isNotRead:
        return "is_not_read";
      case StudentOfEpisodeColumns.periodId:
        return "period_id";
      case StudentOfEpisodeColumns.planId:
        return "plan_id";
      case StudentOfEpisodeColumns.rate:
        return "rate";
      case StudentOfEpisodeColumns.sessionId:
        return "session_id";
      case StudentOfEpisodeColumns.studentId:
        return "student_id";
      case StudentOfEpisodeColumns.typeExamId:
        return "type_exam_id";
      case StudentOfEpisodeColumns.name:
        return "name";
      case StudentOfEpisodeColumns.state:
        return "state";
      case StudentOfEpisodeColumns.generalBehaviorType:
        return "general_behavior_type";
      case StudentOfEpisodeColumns.track:
        return "track";
      case StudentOfEpisodeColumns.testRegister:
        return "test_register";
      case StudentOfEpisodeColumns.episodeId:
        return "episode_id";
      case StudentOfEpisodeColumns.stateDate:
        return "state_date";
      default:
        return "";
    }
  }
}
 

enum EducationalPlanColumns {
  planListen, planReviewbig, planReviewSmall, planTlawa,episodeId, studentId
}

extension MyEnumEducationalPlanColumns on EducationalPlanColumns {
  String get value {
    switch (this) {
      case EducationalPlanColumns.planListen:
        return "plan_listen";
      case EducationalPlanColumns.planReviewbig:
        return "plan_review_big";
      case EducationalPlanColumns.planReviewSmall:
        return "plan_review_small";
      case EducationalPlanColumns.planTlawa:
        return "plan_tlawa";
      case EducationalPlanColumns.episodeId:
        return "episodeId";
      case EducationalPlanColumns.studentId:
        return "studentId";
      default:
        return "";
    }
  }
}

enum ListenLineColumns {
  linkId,
  typeFollow,
  actualDate,
  fromSuraId,
  fromAya,
  toAya,
  toSuraId,
  totalMstkQty,
  totalMstkQlty,
  totalMstkRead,
}

extension MyEnumListenLineColumns on ListenLineColumns {
  String get value {
    switch (this) {
      case ListenLineColumns.linkId:
        return "link_id";
      case ListenLineColumns.typeFollow:
        return "type_follow";
      case ListenLineColumns.actualDate:
        return "actual_date";
      case ListenLineColumns.fromSuraId:
        return "from_surah";
      case ListenLineColumns.fromAya:
        return "from_aya";
      case ListenLineColumns.toSuraId:
        return "to_surah";
      case ListenLineColumns.toAya:
        return "to_aya";
      case ListenLineColumns.totalMstkQty:
        return "total_mstk_qty";
      case ListenLineColumns.totalMstkQlty:
        return "total_mstk_qlty";
      case ListenLineColumns.totalMstkRead:
        return "total_mstk_read";
      default:
        return "";
    }
  }
}


enum PlanLinesColumns {
  listen, reviewbig, reviewsmall, tlawa,episodeId, studentId
}

extension MyEnumPlanLinesColumns on PlanLinesColumns {
  String get value {
    switch (this) {
      case PlanLinesColumns.listen:
        return "listen";
      case PlanLinesColumns.reviewbig:
        return "reviewbig";
      case PlanLinesColumns.reviewsmall:
        return "reviewsmall";
      case PlanLinesColumns.tlawa:
        return "tlawa";
      case PlanLinesColumns.episodeId:
        return "episodeId";
      case PlanLinesColumns.studentId:
        return "studentId";
      default:
        return "";
    }
  }
}

enum BehaviourTypesColumns {
  id, name
}

extension MyEnumBehaviourTypesColumns on BehaviourTypesColumns {
  String get value {
    switch (this) {
      case BehaviourTypesColumns.id:
        return "id";
      case BehaviourTypesColumns.name:
        return "name";
      default:
        return "";
    }
  }
}
enum BehavioursColumns {
  linkId, name
}

extension MyEnumBehavioursColumns on BehavioursColumns {
  String get value {
    switch (this) {
      case BehavioursColumns.linkId:
        return "linkId";
      case BehavioursColumns.name:
        return "name";
      default:
        return "";
    }
  }
}

enum NewBehaviourColumns {
  planId, behaviorId, sendToParent, sendToTeacher
}

extension MyEnumNewBehaviourColumns on NewBehaviourColumns {
  String get value {
    switch (this) {
      case NewBehaviourColumns.planId:
        return "planId";
      case NewBehaviourColumns.behaviorId:
        return "behaviorId";
      case NewBehaviourColumns.sendToParent:
        return "sendToParent";
      case NewBehaviourColumns.sendToTeacher:
        return "sendToTeacher";
      default:
        return "";
    }
  }
}

enum StudentStateColumns {
  studentId,planId,state,date
}

extension MyEnumStudentStateColumns on StudentStateColumns {
  String get value {
    switch (this) {
      case StudentStateColumns.studentId:
        return "studentId";
      case StudentStateColumns.planId:
        return "planId";
      case StudentStateColumns.state:
        return "state";
      case StudentStateColumns.date:
        return "date";
      default:
        return "";
    }
  }
}
enum StudentGeneralBehaviorColumns {
  studentId,generalBehavior
}

extension MyEnumStudentGeneralBehaviorColumns on StudentGeneralBehaviorColumns {
  String get value {
    switch (this) {
      case StudentGeneralBehaviorColumns.studentId:
        return "studentId";
      case StudentGeneralBehaviorColumns.generalBehavior:
        return "generalBehavior";
      default:
        return "";
    }
  }
}
