import 'dart:async';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:maknoon/controller/data_sync_controller.dart';
import 'package:maknoon/main.dart';
import 'package:maknoon/model/core/behaviour/behaviour.dart';
import 'package:maknoon/model/core/behaviour/student_general_behavior.dart';
import 'package:maknoon/model/core/center_test/center_prepar_type.dart';
import 'package:maknoon/model/core/center_test/test_branch.dart';
import 'package:maknoon/model/core/educational/educational.dart';
import 'package:maknoon/model/core/educational/educational_plan.dart';
import 'package:maknoon/model/core/episodes/check_students_responce.dart';
import 'package:maknoon/model/core/episodes/episode.dart';
import 'package:maknoon/model/core/episodes/student_of_episode.dart';
import 'package:maknoon/model/core/episodes/student_state.dart';
import 'package:maknoon/model/core/listen_line.dart';
import 'package:maknoon/model/core/notification/notification_model.dart';
import 'package:maknoon/model/core/plan_lines/mistakes_plan_line.dart';
import 'package:maknoon/model/core/plan_lines/plan_line.dart';
import 'package:maknoon/model/core/plan_lines/plan_lines.dart';
import 'package:maknoon/model/core/quran/surah.dart';
import 'package:maknoon/model/core/shared/constants.dart';
import 'package:maknoon/model/core/test/calendar_center.dart';
import 'package:maknoon/model/core/test/center.dart';
import 'package:maknoon/model/core/test/period.dart';
import 'package:maknoon/model/core/user/auth_model.dart';
import 'package:maknoon/model/services/behaviours_service.dart';
import 'package:maknoon/model/services/center_test_service.dart';
import 'package:maknoon/model/services/complaints_service.dart';
import 'package:maknoon/model/services/data_sync_service.dart';
import 'package:maknoon/model/services/educational_plan_service.dart';
import 'package:maknoon/model/services/episodes_service.dart';
import 'package:maknoon/model/services/listen_line_service.dart';
import 'package:maknoon/model/services/notification_service.dart';
import 'package:maknoon/model/services/plan_lines_service.dart';
import 'package:maknoon/model/services/students_of_episode_service.dart';
import 'package:maknoon/model/services/test_service.dart';
import 'package:maknoon/model/services/user_service.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import '../model/core/episodes/check_episodes_responce.dart';
import '../model/core/shared/response_content.dart';
import '../model/core/shared/status_and_types.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../model/helper/api_helper.dart';
import '../ui/shared/utils/waitting_dialog.dart';

class HomeController extends GetxController {
  int _currentPageIndex = 1;
  int _currentIndex = 1;
  late bool _gettingEpisodes, _hasError;
  late bool _gettingStudentsOfEpisode, _hasErrorStudentsOfEpisode;
  late bool _gettingPlanLines, _hasErrorPlanLines;
  late bool _gettingEducationalPlan, _hasErrorEducationalPlan;
  late bool _gettingBehaviours, _hasErrorBehaviours;
  late bool _gettingNotifications, _hasErrorNotifications;
  late bool _gettingTest, _hasErrorTest;
  late bool _gettingCalendarCenter, _hasErrorCalendarCenter;
  late bool _gettingCenterTest, _hasErrorCenterTest;
  late bool _isWorkLocal;

  AuthModel? userLogin;
  late ResponseContent responseEpisodes,
      responseStudentsOfEpisode,
      responsePlanLines,
      responseEducationalPlan,
      responseBehaviours,
      responseNotifications,
      responseTest,
      responseCalendarCenter,
      responseCenterTest;
  List<Episode> _listEpisodes = [];
  List<StudentOfEpisode> _listStudentsOfEpisode = [];
  List<Behaviour>? _listBehaviours;
  List<String>? _listBehavioursOfStudent;
  List<NotificationModel>? _listNotifications;
  List<Period>? _listPeriods;
  List<Center>? _listCenters;
  List<CalendarCenter>? _listCalendarCenter;
  List<CenterPreparType>? _listCenterPreparTypes;
  List<TestBranch>? _listTestbranchs;
  PlanLines? planLines;
  EducationalPlan? educationalPlan;
  Behaviour? selectedBehaviour;
  Period? selectedPeriod;
  Center? selectedCenter;
  // String studentState = '';
  @override
  void onInit() async {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    initFilds();
    await getUserLocal();
    await getIsWorkLocal();
    loadData();
    Get.put(DataSyncController(isUploadToServer: true));
    Future.delayed(const Duration(seconds: 2), () {
      checkEpisodes();
    });
  }

  Future uploadToServerChanged() async {
    DataSyncController dataSyncController =
        Get.put(DataSyncController(isUploadToServer: true));
    await dataSyncController.loadChangedDataLocal(isInit: true);
    if (dataSyncController.isUploadToServer &&
        !dataSyncController.isNoChanges) {
      final ApiHelper apiHelper = ApiHelper();
      bool isConected = await apiHelper.testConected();
      if (isConected) {
        await dataSyncController.uploadToServer();
      }
    }
  }

  initStudntData() {
    planLines = null;
    educationalPlan = null;
    _listBehaviours = null;
    _listBehavioursOfStudent = null;
    selectedBehaviour = null;
    _listPeriods = null;
    _listCenters = null;
    selectedPeriod = null;
    selectedCenter = null;
    _listCalendarCenter = null;
    //   studentState = '';
  }

  initFilds() {
    _gettingEpisodes = false;
    _hasError = false;
    _gettingStudentsOfEpisode = false;
    _hasErrorStudentsOfEpisode = false;
    _gettingCalendarCenter = false;
    _hasErrorCalendarCenter = false;
    _isWorkLocal = false;
  }

  claerDataCenterTest() {
    _gettingCenterTest = false;
    _hasErrorCenterTest = false;
    _listCenterPreparTypes = null;
    _listTestbranchs = null;
  }

  Future loadData() async {
    if (isWorkLocal) {
      loadEpisodesLocal();
    } else {
      loadEpisodes(isInit: true);
    }
  }

  Future<ResponseContent> checkEpisodes() async {
    ResponseContent checkEpisodesResponse = await EdisodesService()
        .checkEpisodes(
            userLogin!.teachId, _listEpisodes.map((e) => e.id).toList());
    // ResponseContent checkEpisodesResponse = await EdisodesService()
    //     .checkEpisodes(
    //         24298, _listEpisodes.map((e) => e.id).toList());
    if (checkEpisodesResponse.isSuccess || checkEpisodesResponse.isNoContent) {
      CheckEpisodesResponce checkEpisodesResponce = checkEpisodesResponse.data;
      if (checkEpisodesResponce.update) {
        if (await CostomDailogs.dialogWithText(
            text: 'episode_data_is_being_updated'.tr)) {
          bool isCompleted = await Get.dialog(cupertino.Builder(
              builder: (cupertino.BuildContext dialogContext) {
            changeEpisodes(checkEpisodesResponce, dialogContext);
            return cupertino.WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const cupertino.CupertinoAlertDialog(
                content: WaitingDialog(),
              ),
            );
          }));
          if (!isCompleted) {
            CostomDailogs.warringDialogWithGet(
                msg: 'error_get_PlanLine_students'.tr);
          } else {
            Get.offAll(() => const SplashScreen(),
                duration: const Duration(seconds: 2),
                curve: cupertino.Curves.easeInOut,
                transition: Transition.fadeIn);
          }
        }
      }
    }
    update();
    return checkEpisodesResponse;
  }

  Future<ResponseContent> checkStudents(int episodeId) async {
    ResponseContent checkStudentsResponse = await StudentsOfEpisodeService()
        .checkStudents(
            episodeId, _listStudentsOfEpisode.map((e) => e.id ?? 0).toList());
    if (checkStudentsResponse.isSuccess || checkStudentsResponse.isNoContent) {
      CheckStudentsResponce checkStudents = checkStudentsResponse.data;
      if (checkStudents.update) {
        if (await CostomDailogs.dialogWithText(
            text: 'student_episode_data_is_being_updated'.tr)) {
          bool isCompleted = await Get.dialog(cupertino.Builder(
              builder: (cupertino.BuildContext dialogContext) {
            changeStudents(checkStudents, dialogContext, episodeId);
            return cupertino.WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const cupertino.CupertinoAlertDialog(
                content: WaitingDialog(),
              ),
            );
          }));
          if (!isCompleted) {
            CostomDailogs.warringDialogWithGet(
                msg: 'error_get_PlanLine_students'.tr);
          } else {
            Get.offAll(() => const SplashScreen(),
                duration: const Duration(seconds: 2),
                curve: cupertino.Curves.easeInOut,
                transition: Transition.fadeIn);
          }
        }
      }
    }
    update();
    return checkStudentsResponse;
  }

  changeEpisodes(CheckEpisodesResponce checkEpisodesResponce,
      cupertino.BuildContext buildContext) async {
        final navigator = cupertino.Navigator.of(buildContext);
    bool isCompleted = true;
    if (checkEpisodesResponce.deletedEpisodes.isNotEmpty) {
      for (var episodeId in checkEpisodesResponce.deletedEpisodes) {
        await EdisodesService().deletedEpisode(episodeId);
        await PlanLinesService().deleteAllPlanLinesOfEpisode(episodeId);
        await EducationalPlanService()
            .deleteAllEducationalPlansOfEpisode(episodeId);

        List<StudentOfEpisode> listStudentOfEpisode =
            await StudentsOfEpisodeService()
                    .getStudentsOfEpisodeLocal(episodeId) ??
                [];
        if (listStudentOfEpisode.isNotEmpty) {
          for (var student in listStudentOfEpisode) {
            //Student State
            await StudentsOfEpisodeService()
                .deleteStudentStateOfEp(student.id ?? 0);
            await ListenLineService().deleteListenLineStudent(student.id ?? 0);
            await BehavioursService().deleteBehavioursStudent(student.id ?? 0);
            await StudentsOfEpisodeService()
                .deleteStudentGeneralBehavior(student.id ?? 0);
          }
        }
        await StudentsOfEpisodeService().deleteStudentsOfEpisode(episodeId);
      }
    }
    if (checkEpisodesResponce.newEpisodes.isNotEmpty) {
      List<PlanLines> planLines = [];
      for (var episode in checkEpisodesResponce.newEpisodes) {
        for (var student in episode.students) {
          ResponseContent planLinesResponse = await PlanLinesService()
              .getPlanLines(episode.id, student.studentId!);
          if (planLinesResponse.isSuccess) {
            planLines.add(planLinesResponse.data);
          } else {
            isCompleted = false;
          }
        }
        if (isCompleted) {
          await EdisodesService().setEdisodeLocal(episode);
          await StudentsOfEpisodeService()
              .setStudentsOfEpisodeLocal(episode.students);
          for (var planLine in planLines) {
            PlanLinesService().setPlanLinesLocal(planLine);
          }
        }
      }
    }
    
    navigator.pop(isCompleted);
  }

  changeStudents(CheckStudentsResponce checkStudentsResponce,
      cupertino.BuildContext buildContext, int episodeId) async {
     final navigator = cupertino.Navigator.of(buildContext);    
    bool isCompleted = true;
    if (checkStudentsResponce.deletedLinks.isNotEmpty) {
      for (var id in checkStudentsResponce.deletedLinks) {
        StudentOfEpisode? student =
            await StudentsOfEpisodeService().getStudentLocal(episodeId, id);
        await EducationalPlanService()
            .deleteAllEducationalPlansOfStudent(student?.studentId ?? 0);
        await PlanLinesService()
            .deleteAllPlanLinesOfStudent(student?.studentId ?? 0);
        //
        await StudentsOfEpisodeService().deleteStudentStateOfEp(id);
        await ListenLineService().deleteListenLineStudent(id);
        await BehavioursService().deleteBehavioursStudent(id);
        await StudentsOfEpisodeService().deleteStudentGeneralBehavior(id);
        await StudentsOfEpisodeService().deleteStudent(id);
      }
    }
    if (checkStudentsResponce.newLinks.isNotEmpty) {
      List<PlanLines> planLines = [];
      for (var student in checkStudentsResponce.newLinks) {
        ResponseContent planLinesResponse = await PlanLinesService()
            .getPlanLines(episodeId, student.studentId!);
        if (planLinesResponse.isSuccess) {
          planLines.add(planLinesResponse.data);
        } else {
          isCompleted = false;
        }

        if (isCompleted) {
          await StudentsOfEpisodeService()
              .setStudentsOfEpisodeLocal(checkStudentsResponce.newLinks);
          for (var planLine in planLines) {
            PlanLinesService().setPlanLinesLocal(planLine);
          }
        }
      }
    }

    navigator.pop(isCompleted);
  }

  Future loadEpisodesLocal() async {
    List<Episode>? listEpisodes = await EdisodesService().getEdisodesLocal();
    if (listEpisodes != null) {
      _listEpisodes = List<Episode>.from(listEpisodes);
      hasError = false;
      responseEpisodes = ResponseContent(statusCode: '200', success: true);
    } else {
      _listEpisodes = [];
      hasError = true;
      responseEpisodes = ResponseContent(statusCode: '400', success: false);
    }
    update();
  }

  Future getUserLocal() async {
    userLogin = await UserService().getUserLocal;
    update();
  }

  Future removeUserLocal() async {
    userLogin = await UserService().removeUserLocal();
    update();
  }

  Future getIsWorkLocal() async {
    isWorkLocal = await DataSyncService().getIsWorkLocal;
    update();
  }

  Future loadEpisodes({bool isInit = false}) async {
    if (isInit) {
      _gettingEpisodes = true;
    } else {
      gettingParks = true;
    }
    responseEpisodes = await getEpisodes();
    if (isInit) {
      _hasError = !(responseEpisodes.isSuccess);
      _gettingEpisodes = false;
    } else {
      hasError = !(responseEpisodes.isSuccess);
      gettingParks = false;
    }
  }

  Future loadStudentsOfEpisode(String episodeId, {bool isInit = false}) async {
    if (isWorkLocal) {
      loadStudentsOfEpisodeLocal(int.parse(episodeId), isInit: isInit);
    } else {
      if (isInit) {
        _gettingStudentsOfEpisode = true;
      } else {
        gettingStudentsOfEpisode = true;
      }
      responseStudentsOfEpisode = await getStudentsOfEpisode(episodeId);
      if (isInit) {
        _hasErrorStudentsOfEpisode = !(responseStudentsOfEpisode.isSuccess);
        _gettingStudentsOfEpisode = false;
      } else {
        hasErrorStudentsOfEpisode = !(responseStudentsOfEpisode.isSuccess);
        gettingStudentsOfEpisode = false;
      }
    }
  }

  Future loadStudentsOfEpisodeLocal(int episodeId,
      {bool isInit = false}) async {
    if (isInit) {
      _gettingStudentsOfEpisode = true;
    } else {
      gettingStudentsOfEpisode = true;
    }
    List<StudentOfEpisode>? listStudentOfEpisode =
        await StudentsOfEpisodeService().getStudentsOfEpisodeLocal(episodeId);
    if (listStudentOfEpisode != null) {
      for(int i=0; i<listStudentOfEpisode.length;i++){
        listStudentOfEpisode[i].state =
            listStudentOfEpisode[i].stateDate == DateFormat('yyyy-MM-dd').format(DateTime.now())
                ? listStudentOfEpisode[i].state
                : 'student_preparation'.tr;
      }
      // listStudentOfEpisode.forEach((element) async {
      //   element.state =
      //       element.stateDate == DateFormat('yyyy-MM-dd').format(DateTime.now())
      //           ? element.state
      //           : 'student_preparation'.tr;
      // });

      _listStudentsOfEpisode =
          List<StudentOfEpisode>.from(listStudentOfEpisode);

      hasErrorStudentsOfEpisode = false;
      responseStudentsOfEpisode =
          ResponseContent(statusCode: '200', success: true);
    } else {
      _listStudentsOfEpisode = [];
      hasErrorStudentsOfEpisode = true;
      responseStudentsOfEpisode =
          ResponseContent(statusCode: '400', success: false);
    }
    if (isInit) {
      _gettingStudentsOfEpisode = false;
    } else {
      gettingStudentsOfEpisode = false;
    }

    update();
  }

  Future loadPlanLines(String episodeId, String studentId,
      {bool isInit = false}) async {
    if (isWorkLocal) {
      loadPlanLinesLocal(int.parse(episodeId), int.parse(studentId),
          isInit: isInit);
    } else {
      if (isInit) {
        _gettingPlanLines = true;
      } else {
        gettingPlanLines = true;
      }
      responsePlanLines = await getPlanLines(episodeId, studentId);
      if (isInit) {
        _hasErrorPlanLines = !(responsePlanLines.isSuccess);
        _gettingPlanLines = false;
      } else {
        hasErrorPlanLines = !(responsePlanLines.isSuccess);
        gettingPlanLines = false;
      }
    }
  }

  Future loadPlanLinesLocal(int episodeId, int studentId,
      {bool isInit = false}) async {
    if (isInit) {
      _gettingPlanLines = true;
    } else {
      gettingPlanLines = true;
    }
    PlanLines? planLinesLocal =
        await PlanLinesService().getPlanLinesLocal(episodeId, studentId);
    if (planLinesLocal != null) {
      planLines = planLinesLocal;
      hasErrorPlanLines = false;
      responsePlanLines = ResponseContent(statusCode: '200', success: true);
    } else {
      planLines = null;
      hasErrorPlanLines = true;
      responsePlanLines = ResponseContent(statusCode: '400', success: false);
    }
    if (isInit) {
      _gettingPlanLines = false;
    } else {
      gettingPlanLines = false;
    }
    update();
  }

  Future loadEducationalPlan(String episodeId, String studentId,
      {bool isInit = false}) async {
    if (isWorkLocal) {
      loadEducationalPlanLocal(int.parse(episodeId), int.parse(studentId),
          isInit: isInit);
    } else {
      if (isInit) {
        _gettingEducationalPlan = true;
      } else {
        gettingEducationalPlan = true;
      }
      responseEducationalPlan = await getEducationalPlan(episodeId, studentId);
      if (isInit) {
        _hasErrorEducationalPlan = !(responseEducationalPlan.isSuccess);
        _gettingEducationalPlan = false;
      } else {
        hasErrorEducationalPlan = !(responseEducationalPlan.isSuccess);
        gettingEducationalPlan = false;
      }
    }
  }

  Future loadEducationalPlanLocal(int episodeId, int studentId,
      {bool isInit = false}) async {
    if (isInit) {
      _gettingEducationalPlan = true;
    } else {
      gettingEducationalPlan = true;
    }
    EducationalPlan newEducationalPlan = await EducationalPlanService()
        .getEducationalPlanLocal(episodeId, studentId);
     educationalPlan = newEducationalPlan;
      hasErrorEducationalPlan = false;
      responseEducationalPlan =
          ResponseContent(statusCode: '200', success: true);
     
    if (isInit) {
      _gettingEducationalPlan = false;
    } else {
      gettingEducationalPlan = false;
    }
    update();
  }

  Future loadBehaviours(String linkId, {bool isInit = false}) async {
    if (isWorkLocal) {
      loadBehavioursLocal(int.parse(linkId), isInit: isInit);
    } else {
      if (isInit) {
        _gettingBehaviours = true;
      } else {
        gettingBehaviours = true;
      }
      responseBehaviours = await getBehavioursOfStudent(
        linkId,
      );
      if (responseBehaviours.isSuccess || responseBehaviours.isNoContent) {
        responseBehaviours = await getBehaviours();
      }
      if (isInit) {
        _hasErrorBehaviours = !(responseBehaviours.isSuccess);
        _gettingBehaviours = false;
      } else {
        hasErrorBehaviours = !(responseBehaviours.isSuccess);
        gettingBehaviours = false;
      }
    }
  }

  Future loadBehavioursLocal(int linkId, {bool isInit = false}) async {
    if (isInit) {
      _gettingBehaviours = true;
    } else {
      gettingBehaviours = true;
    }
    List<Behaviour>? newEducationalPlan =
        await BehavioursService().getBehaviourTypesLocal();
    List<BehaviourStudent>? newBehaviourStudents =
        await BehavioursService().getBehavioursStudentLocal(linkId);
    if (newEducationalPlan != null && newBehaviourStudents != null) {
      _listBehavioursOfStudent =
          newBehaviourStudents.map((e) => e.name).toList();
      _listBehaviours = List<Behaviour>.from(newEducationalPlan);
      hasErrorBehaviours = false;
      responseBehaviours = ResponseContent(statusCode: '200', success: true);
    } else {
      _listBehavioursOfStudent = [];
      _listBehaviours = [];
      hasErrorBehaviours = true;
      responseBehaviours = ResponseContent(statusCode: '400', success: false);
    }
    if (isInit) {
      _gettingBehaviours = false;
    } else {
      gettingBehaviours = false;
    }
    update();
  }

  Future loadTest(int episodeId, {bool isInit = false}) async {
    if (isInit) {
      _gettingTest = true;
    } else {
      gettingTest = true;
    }
    responseTest = await getPeriods();
    if (responseTest.isSuccess || responseTest.isNoContent) {
      responseTest = await getCenters(episodeId);
    }
    if (isInit) {
      _hasErrorTest = !(responseTest.isSuccess);
      _gettingTest = false;
    } else {
      hasErrorTest = !(responseTest.isSuccess);
      gettingTest = false;
    }
  }

  Future loadCenterTest(int centerPreprationId, {bool isInit = false}) async {
    if (isInit) {
      _gettingCenterTest = true;
    } else {
      gettingCenterTest = true;
    }
    responseCenterTest = await getCenterPreparTypes(centerPreprationId);
    if (isInit) {
      _hasErrorCenterTest = !(responseCenterTest.isSuccess);
      _gettingCenterTest = false;
    } else {
      hasErrorCenterTest = !(responseCenterTest.isSuccess);
      gettingCenterTest = false;
    }
  }

  Future loadNotifications(String teacherId, {bool isInit = false}) async {
    if (isInit) {
      _gettingNotifications = true;
    } else {
      gettingNotifications = true;
    }
    responseNotifications = await getNotifications(
      teacherId,
    );
    if (isInit) {
      _hasErrorNotifications = !(responseNotifications.isSuccess);
      _gettingNotifications = false;
    } else {
      hasErrorNotifications = !(responseNotifications.isSuccess);
      gettingNotifications = false;
    }
  }

  Future loadCalendarCenter(int centerId, int episodeId, int periodId,
      {bool isInit = false}) async {
    if (isInit) {
      _gettingCalendarCenter = true;
    } else {
      gettingCalendarCenter = true;
    }
    responseCalendarCenter =
        await getCalendarCenter(centerId, episodeId, periodId);
    if (isInit) {
      _hasErrorCalendarCenter = !(responseCalendarCenter.isSuccess);
      _gettingCalendarCenter = false;
    } else {
      hasErrorCalendarCenter = !(responseCalendarCenter.isSuccess);
      gettingCalendarCenter = false;
    }
  }

  Future<ResponseContent> getEpisodes() async {
    ResponseContent episodesResponse =
        await EdisodesService().getEdisodes(userLogin!.teachId.toString());
    if (episodesResponse.isSuccess || episodesResponse.isNoContent) {
      _listEpisodes = List<Episode>.from(episodesResponse.data);
    }
    update();
    return episodesResponse;
  }

  Future<ResponseContent> getBehavioursOfStudent(String linkId) async {
    ResponseContent behavioursOfStudentResponse =
        await BehavioursService().getBehavioursOfStudent(linkId);
    if (behavioursOfStudentResponse.isSuccess ||
        behavioursOfStudentResponse.isNoContent) {
      _listBehavioursOfStudent =
          List<String>.from(behavioursOfStudentResponse.data);
    }
    update();
    return behavioursOfStudentResponse;
  }

  Future<ResponseContent> getBehaviours() async {
    ResponseContent behavioursOfStudentResponse =
        await BehavioursService().getBehaviours();
    if (behavioursOfStudentResponse.isSuccess ||
        behavioursOfStudentResponse.isNoContent) {
      _listBehaviours = List<Behaviour>.from(behavioursOfStudentResponse.data);
    }
    update();
    return behavioursOfStudentResponse;
  }

  Future<ResponseContent> getStudentsOfEpisode(String episodeId) async {
    ResponseContent studentsOfEpisodeResponse =
        await StudentsOfEpisodeService().getStudentsOfEpisode(episodeId);
    if (studentsOfEpisodeResponse.isSuccess ||
        studentsOfEpisodeResponse.isNoContent) {
      _listStudentsOfEpisode =
          List<StudentOfEpisode>.from(studentsOfEpisodeResponse.data);
    }
    update();
    return studentsOfEpisodeResponse;
  }

  Future<ResponseContent> getPlanLines(
      String episodeId, String studentId) async {
    ResponseContent planLinesResponse = await PlanLinesService()
        .getPlanLines(int.parse(episodeId), int.parse(studentId));
    if (planLinesResponse.isSuccess || planLinesResponse.isNoContent) {
      planLines = planLinesResponse.data;
    }
    update();
    return planLinesResponse;
  }

  Future<ResponseContent> getEducationalPlan(
      String episodeId, String studentId) async {
    ResponseContent educationalPlanResponse = await EducationalPlanService()
        .getEducationalPlan(int.parse(episodeId), int.parse(studentId));
    if (educationalPlanResponse.isSuccess ||
        educationalPlanResponse.isNoContent) {
      educationalPlan = educationalPlanResponse.data;
    }
    update();
    return educationalPlanResponse;
  }

  Future<ResponseContent> getNotifications(String teacherId) async {
    ResponseContent notificationResponse =
        await NotificationService().getNotification(teacherId);
    if (notificationResponse.isSuccess || notificationResponse.isNoContent) {
      _listNotifications =
          List<NotificationModel>.from(notificationResponse.data);
    }
    update();
    return notificationResponse;
  }

  Future<ResponseContent> consultNotification(int notificationId) async {
    ResponseContent consultNotification =
        await NotificationService().consultNotification(notificationId);
    update();
    return consultNotification;
  }

  Future<ResponseContent> addComplaints(
      String subject, String description) async {
    ResponseContent addComplaintsResponse = await ComplaintsService()
        .addComplaints(userLogin!.userId, subject, description);
    update();
    return addComplaintsResponse;
  }

  Future<ResponseContent> getPeriods() async {
    ResponseContent periodsResponse = await TestService().getPeriods();
    if (periodsResponse.isSuccess || periodsResponse.isNoContent) {
      _listPeriods = List<Period>.from(periodsResponse.data);
    }
    update();
    return periodsResponse;
  }

  Future<ResponseContent> getCenters(int episodeId) async {
    ResponseContent centersResponse = await TestService()
        .getCenters(userLogin!.gender, episodeId, userLogin!.userId);

    if (centersResponse.isSuccess || centersResponse.isNoContent) {
      _listCenters = List<Center>.from(centersResponse.data);
    }
    update();
    return centersResponse;
  }

  Future<ResponseContent> getCalendarCenter(
      int centerId, int episodeId, int periodId) async {
    ResponseContent calendarCenterResponse = await TestService()
        .getCalendarCenter(userLogin!.gender, centerId, episodeId, periodId,
            userLogin!.userId);

    if (calendarCenterResponse.isSuccess ||
        calendarCenterResponse.isNoContent) {
      _listCalendarCenter =
          List<CalendarCenter>.from(calendarCenterResponse.data);
    } else {
      _listCalendarCenter = null;
    }
    update();
    return calendarCenterResponse;
  }

  Future<ResponseContent> getCenterPreparTypes(int centerPreprationId) async {
    ResponseContent centerPreparTypesResponse =
        await CenterTestService().getCenterPreparTypes(
      centerPreprationId,
    );

    if (centerPreparTypesResponse.isSuccess ||
        centerPreparTypesResponse.isNoContent) {
      _listCenterPreparTypes =
          List<CenterPreparType>.from(centerPreparTypesResponse.data);
    } else {
      _listCenterPreparTypes = null;
    }
    update();
    return centerPreparTypesResponse;
  }

  Future<ResponseContent> getTestbranchs(int testId, String trackk) async {
    ResponseContent testbranchsResponse =
        await CenterTestService().getTestBranches(testId, trackk);

    if (testbranchsResponse.isSuccess || testbranchsResponse.isNoContent) {
      _listTestbranchs = List<TestBranch>.from(testbranchsResponse.data);
    } else {
      _listTestbranchs = null;
    }
    update();
    return testbranchsResponse;
  }

  Future<ResponseContent> addStudentTestSession(int studentId, int branchId,
      int testNameId, int testTimeId, String trackk, int episodeId) async {
    ResponseContent testbranchsResponse = await CenterTestService()
        .addStudentTestSession(
            studentId, branchId, testNameId, testTimeId, trackk);
    if (testbranchsResponse.isSuccess) {
      testbranchsResponse = await getStudentsOfEpisode(episodeId.toString());
    }
    update();
    return testbranchsResponse;
  }

  Future<String> getStudentStateToDayLocal(
    int planId,
  ) async {
    StudentState? studentState =
        await StudentsOfEpisodeService().getStudentStateToDayLocal(planId);
    if (studentState != null) {
      return studentState.state.tr;
    } else {
      return 'student_preparation'.tr;
    }
  }

  Future<String?> getStudentGeneralBehaviorLocal(
    int linkID,
  ) async {
    StudentGeneralBehavior? studentGeneralBehavior =
        await StudentsOfEpisodeService().getStudentGeneralBehaviorLocal(linkID);
    if (studentGeneralBehavior != null) {
      return studentGeneralBehavior.generalBehavior.tr;
    } else {
      return null;
    }
  }

  Future<ResponseContent> setAttendance(
      int planId, String filter, int id) async {
    ResponseContent testbranchsResponse = ResponseContent();
    if (isWorkLocal) {
      await StudentsOfEpisodeService().setStudentStateLocal(StudentState(
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          planId: planId,
          studentId: id,
          state: filter));

      int index =
          _listStudentsOfEpisode.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _listStudentsOfEpisode[index].state = filter.tr;
        _listStudentsOfEpisode[index].stateDate =
            DateFormat('yyyy-MM-dd').format(DateTime.now());
        await StudentsOfEpisodeService()
            .updateStudentsOfEpisodeLocal(_listStudentsOfEpisode[index]);
        uploadToServerChanged();
      }
      testbranchsResponse = ResponseContent(statusCode: '200', success: true);
    } else {
      testbranchsResponse =
          await StudentsOfEpisodeService().setAttendance(planId, filter);
      if (testbranchsResponse.isSuccess) {
        int index =
            _listStudentsOfEpisode.indexWhere((element) => element.id == id);
        if (index >= 0) {
          _listStudentsOfEpisode[index].state = filter.tr;
        }
      }
    }
    update();
    return testbranchsResponse;
  }

  Future<ResponseContent> setGeneralBehavior(
      String generalBehavior, int id) async {
    ResponseContent generalBehaviorResponse = ResponseContent();
    if (isWorkLocal) {
      await StudentsOfEpisodeService().setStudentGeneralBehaviorLocal(
          StudentGeneralBehavior(
              studentId: id, generalBehavior: generalBehavior));
      int index =
          _listStudentsOfEpisode.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _listStudentsOfEpisode[index].generalBehaviorType = generalBehavior.tr;
        await StudentsOfEpisodeService()
            .updateStudentsOfEpisodeLocal(_listStudentsOfEpisode[index]);
        uploadToServerChanged();
      }
      generalBehaviorResponse =
          ResponseContent(statusCode: '200', success: true);
    } else {
      generalBehaviorResponse = await StudentsOfEpisodeService()
          .setGeneralBehavior(id, generalBehavior);
      if (generalBehaviorResponse.isSuccess) {
        int index =
            _listStudentsOfEpisode.indexWhere((element) => element.id == id);
        if (index >= 0) {
          _listStudentsOfEpisode[index].generalBehaviorType =
              generalBehavior.tr;
        }
      }
    }
    update();
    return generalBehaviorResponse;
  }

  Future<ResponseContent> cancelStudentTestSession(
      int sessionId, int episodeId) async {
    ResponseContent testbranchsResponse =
        await CenterTestService().cancelStudentTestSession(sessionId);
    if (testbranchsResponse.isSuccess) {
      testbranchsResponse = await getStudentsOfEpisode(episodeId.toString());
    }
    update();
    return testbranchsResponse;
  }

  // Future<ResponseContent> getOurBankAccounts() async {
  //   ResponseContent ourBankAccountsResponse =
  //       await OurBankAccountsService().ourBankAccounts();
  //   update();
  //   return ourBankAccountsResponse;
  // }

  // Future<ResponseContent> getPeriods({required int parkId}) async {
  //   ResponseContent parksResponse = await PeriodsService().getPeriods(parkId);
  //   update();
  //   return parksResponse;
  // }

  // Future<ResponseContent> getMyRequests() async {
  //   ResponseContent myRequestsResponse =
  //       await MyRequestsService().getMyRequests();
  //   update();
  //   return myRequestsResponse;
  // }

  // Future<ResponseContent> getTerms(int parkId) async {
  //   ResponseContent termsResponse =
  //       await ParkTermsService().getParkTerms(parkId);
  //   update();
  //   return termsResponse;
  // }

  // change
  changeFromSuraPlanLine(Surah surah, String planLine) {
    if (PlanLinesType.listen == planLine) {
      planLines!.listen!.fromSuraName = surah.name;
      planLines!.listen!.fromAya = 1;
    } else if (PlanLinesType.reviewsmall == planLine) {
      planLines!.reviewsmall!.fromSuraName = surah.name;
      planLines!.reviewsmall!.fromAya = 1;
    } else if (PlanLinesType.reviewbig == planLine) {
      planLines!.reviewbig!.fromSuraName = surah.name;
      planLines!.reviewbig!.fromAya = 1;
    } else if (PlanLinesType.tlawa == planLine) {
      planLines!.tlawa!.fromSuraName = surah.name;
      planLines!.tlawa!.fromAya = 1;
    }
    update();
  }

  changeToSuraPlanLine(Surah surah, String planLine) {
    if (PlanLinesType.listen == planLine) {
      planLines!.listen!.toSuraName = surah.name;
      planLines!.listen!.toAya = planLines!.listen!.fromSuraName == surah.name
          ? planLines!.listen!.fromAya
          : 1;
    } else if (PlanLinesType.reviewsmall == planLine) {
      planLines!.reviewsmall!.toSuraName = surah.name;
      planLines!.reviewsmall!.toAya =
          planLines!.reviewsmall!.fromSuraName == surah.name
              ? planLines!.reviewsmall!.fromAya
              : 1;
    } else if (PlanLinesType.reviewbig == planLine) {
      planLines!.reviewbig!.toSuraName = surah.name;
      planLines!.reviewbig!.toAya =
          planLines!.reviewbig!.fromSuraName == surah.name
              ? planLines!.reviewbig!.fromAya
              : 1;
    } else if (PlanLinesType.tlawa == planLine) {
      planLines!.tlawa!.toSuraName = surah.name;
      planLines!.tlawa!.toAya = planLines!.tlawa!.fromSuraName == surah.name
          ? planLines!.tlawa!.fromAya
          : 1;
    }
    update();
  }

  changeFromAyaPlanLine(int aya, String planLine) {
    if (PlanLinesType.listen == planLine) {
      planLines!.listen!.fromAya = aya;
    } else if (PlanLinesType.reviewsmall == planLine) {
      planLines!.reviewsmall!.fromAya = aya;
    } else if (PlanLinesType.reviewbig == planLine) {
      planLines!.reviewbig!.fromAya = aya;
    } else if (PlanLinesType.tlawa == planLine) {
      planLines!.tlawa!.fromAya = aya;
    }
    update();
  }

  changeToAyaPlanLine(int aya, String planLine) {
    if (PlanLinesType.listen == planLine) {
      planLines!.listen!.toAya = aya;
    } else if (PlanLinesType.reviewsmall == planLine) {
      planLines!.reviewsmall!.toAya = aya;
    } else if (PlanLinesType.reviewbig == planLine) {
      planLines!.reviewbig!.toAya = aya;
    } else if (PlanLinesType.tlawa == planLine) {
      planLines!.tlawa!.toAya = aya;
    }
    update();
  }

  addNote(String planLine, Mistakes mistakes) {
    if (PlanLinesType.listen == planLine) {
      planLines!.listen!.mistakes = mistakes;
    } else if (PlanLinesType.reviewsmall == planLine) {
      planLines!.reviewsmall!.mistakes = mistakes;
    } else if (PlanLinesType.reviewbig == planLine) {
      planLines!.reviewbig!.mistakes = mistakes;
    } else if (PlanLinesType.tlawa == planLine) {
      planLines!.tlawa!.mistakes = mistakes;
    }
    update();
  }

  addListenLine(
      String typePlanLine, int id, String episodeId, String studentId) async {
    late PlanLine planLine;
    if (PlanLinesType.listen == typePlanLine) {
      planLine = planLines!.listen!;
    } else if (PlanLinesType.reviewsmall == typePlanLine) {
      planLine = planLines!.reviewsmall!;
    } else if (PlanLinesType.reviewbig == typePlanLine) {
      planLine = planLines!.reviewbig!;
    } else if (PlanLinesType.tlawa == typePlanLine) {
      planLine = planLines!.tlawa!;
    }
    ListenLine listenLine = ListenLine(
        linkId: id,
        actualDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        typeFollow: getTypePlanLine(typePlanLine),
        fromSuraId: Constants.listSurah
            .firstWhere((element) => element.name == planLine.fromSuraName)
            .id,
        toSuraId: Constants.listSurah
            .firstWhere((element) => element.name == planLine.toSuraName)
            .id,
        fromAya: planLine.fromAya,
        toAya: planLine.toAya,
        totalMstkQlty: planLine.mistakes?.totalMstkQlty ?? 0,
        totalMstkQty: planLine.mistakes?.totalMstkQty ?? 0,
        totalMstkRead: planLine.mistakes?.totalMstkRead ?? 0);

    ResponseContent responseContent = ResponseContent();
    if (isWorkLocal) {
      await ListenLineService().setListenLineLocal(listenLine);
      responseContent = ResponseContent(success: true, statusCode: '200');
    } else {
      responseContent = await ListenLineService().postListenLine(listenLine);
    }
    if (responseContent.isSuccess) {
      Educational educational = Educational(
        actualDate: DateTime.tryParse(listenLine.actualDate),
        fromAya: listenLine.fromAya,
        toAya: listenLine.toAya,
        fromSuraName: planLine.fromSuraName,
        toSuraName: planLine.toSuraName,
        totalMstkQty: planLine.mistakes?.totalMstkQty ?? 0,
        totalMstkRead: planLine.mistakes?.totalMstkRead ?? 0,
      );

      ResponseDataListenLine? dataListenLine = responseContent.data;

      if (PlanLinesType.listen == typePlanLine) {
        if (!isWorkLocal) {
          planLines!.listen = dataListenLine?.newStartPoint;
          if (educationalPlan != null) {
            educationalPlan!.planListen.add(educational);
          }
        } else {
          planLines!.listen!.fromSuraName = Constants.listVerse
                      .where((element) =>
                          element.surahId ==
                          Constants.listSurah
                              .firstWhere((element) =>
                                  element.name == planLine.toSuraName)
                              .id)
                      .last
                      .originalSurahOrder ==
                  planLines!.listen!.toAya
              ? Constants
                  .listSurah[Constants.listSurah.indexWhere(
                          (element) => element.name == planLine.toSuraName) +
                      1]
                  .name
              : planLines!.listen!.toSuraName;
          planLines!.listen!.fromAya = Constants.listVerse
                      .where((element) =>
                          element.surahId ==
                          Constants.listSurah
                              .firstWhere((element) =>
                                  element.name == planLine.toSuraName)
                              .id)
                      .last
                      .originalSurahOrder ==
                  planLines!.listen!.toAya
              ? 1
              : planLines!.listen!.toAya + 1;
          planLines!.listen!.toSuraName = '';
          planLines!.listen!.toAya = 0;
          planLines!.listen!.mistakes = null;
          await PlanLinesService().updatePlanLinesLocal(planLines!);
          // educationlPlan
          if (educationalPlan != null) {
            educationalPlan!.planListen.add(educational);
            await EducationalPlanService()
                .setEducationalPlanLocal(educationalPlan!);
          } else {
            EducationalPlan newEducationalPlan = await EducationalPlanService()
                .getEducationalPlanLocal(
                    int.parse(episodeId), int.parse(studentId));
            newEducationalPlan.planListen.add(educational);
            await EducationalPlanService()
                .setEducationalPlanLocal(newEducationalPlan);
          }
        }
      } else if (PlanLinesType.reviewsmall == typePlanLine) {
        if (!isWorkLocal) {
          planLines!.reviewsmall = dataListenLine?.newStartPoint;
          if (educationalPlan != null) {
            educationalPlan!.planReviewSmall.add(educational);
          }
        } else {
          planLines!.reviewsmall!.fromSuraName = Constants.listVerse
                      .where((element) =>
                          element.surahId ==
                          Constants.listSurah
                              .firstWhere((element) =>
                                  element.name == planLine.toSuraName)
                              .id)
                      .last
                      .originalSurahOrder ==
                  planLines!.reviewsmall!.toAya
              ? Constants
                  .listSurah[Constants.listSurah.indexWhere(
                          (element) => element.name == planLine.toSuraName) +
                      1]
                  .name
              : planLines!.reviewsmall!.toSuraName;
          planLines!.reviewsmall!.fromAya = Constants.listVerse
                      .where((element) =>
                          element.surahId ==
                          Constants.listSurah
                              .firstWhere((element) =>
                                  element.name == planLine.toSuraName)
                              .id)
                      .last
                      .originalSurahOrder ==
                  planLines!.reviewsmall!.toAya
              ? 1
              : planLines!.reviewsmall!.toAya + 1;
          planLines!.reviewsmall!.toSuraName = '';
          planLines!.reviewsmall!.toAya = 0;
          planLines!.reviewsmall!.mistakes = null;
          await PlanLinesService().updatePlanLinesLocal(planLines!);
          // educationlPlan
          if (educationalPlan != null) {
            educationalPlan!.planReviewSmall.add(educational);
            await EducationalPlanService()
                .setEducationalPlanLocal(educationalPlan!);
          } else {
            EducationalPlan newEducationalPlan = await EducationalPlanService()
                .getEducationalPlanLocal(
                    int.parse(episodeId), int.parse(studentId));
            newEducationalPlan.planReviewSmall.add(educational);
            await EducationalPlanService()
                .setEducationalPlanLocal(newEducationalPlan);
          }
        }
      } else if (PlanLinesType.reviewbig == typePlanLine) {
        if (!isWorkLocal) {
          planLines!.reviewbig = dataListenLine?.newStartPoint;
          if (educationalPlan != null) {
            educationalPlan!.planReviewbig.add(educational);
          }
        } else {
          planLines!.reviewbig!.fromSuraName = Constants.listVerse
                      .where((element) =>
                          element.surahId ==
                          Constants.listSurah
                              .firstWhere((element) =>
                                  element.name == planLine.toSuraName)
                              .id)
                      .last
                      .originalSurahOrder ==
                  planLines!.reviewbig!.toAya
              ? Constants
                  .listSurah[Constants.listSurah.indexWhere(
                          (element) => element.name == planLine.toSuraName) +
                      1]
                  .name
              : planLines!.reviewbig!.toSuraName;
          planLines!.reviewbig!.fromAya = Constants.listVerse
                      .where((element) =>
                          element.surahId ==
                          Constants.listSurah
                              .firstWhere((element) =>
                                  element.name == planLine.toSuraName)
                              .id)
                      .last
                      .originalSurahOrder ==
                  planLines!.reviewbig!.toAya
              ? 1
              : planLines!.reviewbig!.toAya + 1;
          planLines!.reviewbig!.toSuraName = '';
          planLines!.reviewbig!.toAya = 0;
          planLines!.reviewbig!.mistakes = null;
          await PlanLinesService().updatePlanLinesLocal(planLines!);
          // educationlPlan
          if (educationalPlan != null) {
            educationalPlan!.planReviewbig.add(educational);
            await EducationalPlanService()
                .setEducationalPlanLocal(educationalPlan!);
          } else {
            EducationalPlan newEducationalPlan = await EducationalPlanService()
                .getEducationalPlanLocal(
                    int.parse(episodeId), int.parse(studentId));
            newEducationalPlan.planReviewbig.add(educational);
            await EducationalPlanService()
                .setEducationalPlanLocal(newEducationalPlan);
          }
        }
      } else if (PlanLinesType.tlawa == typePlanLine) {
        if (!isWorkLocal) {
          planLines!.tlawa = dataListenLine?.newStartPoint;
          if (educationalPlan != null) {
            educationalPlan!.planTlawa.add(educational);
          }
        }
        planLines!.tlawa!.fromSuraName = Constants.listVerse
                    .where((element) =>
                        element.surahId ==
                        Constants.listSurah
                            .firstWhere((element) =>
                                element.name == planLine.toSuraName)
                            .id)
                    .last
                    .originalSurahOrder ==
                planLines!.tlawa!.toAya
            ? Constants
                .listSurah[(Constants.listSurah.indexWhere(
                        (element) => element.name == planLine.toSuraName) +
                    1)]
                .name
            : planLines!.tlawa!.toSuraName;
        planLines!.tlawa!.fromAya = Constants.listVerse
                    .where((element) =>
                        element.surahId ==
                        Constants.listSurah
                            .firstWhere((element) =>
                                element.name == planLine.toSuraName)
                            .id)
                    .last
                    .originalSurahOrder ==
                planLines!.tlawa!.toAya
            ? 1
            : planLines!.tlawa!.toAya + 1;
        planLines!.tlawa!.toSuraName = '';
        planLines!.tlawa!.toAya = 0;
        planLines!.tlawa!.mistakes = null;
        await PlanLinesService().updatePlanLinesLocal(planLines!);
        // educationlPlan
        if (educationalPlan != null) {
          educationalPlan!.planTlawa.add(educational);
          await EducationalPlanService()
              .setEducationalPlanLocal(educationalPlan!);
        } else {
          EducationalPlan newEducationalPlan = await EducationalPlanService()
              .getEducationalPlanLocal(
                  int.parse(episodeId), int.parse(studentId));
          newEducationalPlan.planTlawa.add(educational);
          await EducationalPlanService()
              .setEducationalPlanLocal(newEducationalPlan);
        }
      }

      int index = _listStudentsOfEpisode.indexWhere(
          (element) => element.studentId == int.tryParse(studentId));

      if (index >= 0) {
        _listStudentsOfEpisode[index].state = 'present'.tr;
        if (isWorkLocal) {
          await StudentsOfEpisodeService().setStudentStateLocal(StudentState(
              date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              planId: _listStudentsOfEpisode[index].planId!,
              studentId: int.parse(studentId),
              state: 'present'));
        }
      }
    }
    uploadToServerChanged();
    update();

    return responseContent;
  }

  addBehavior(List<bool> dataSend, StudentOfEpisode studentOfEpisode) async {
    ResponseContent responseContent = ResponseContent();
    if (isWorkLocal) {
      await BehavioursService().setNewBehaviourLocal(
          NewBehaviour(
            behaviorId: selectedBehaviour!.id,
            planId: studentOfEpisode.planId!,
            sendToParent: dataSend[0],
            sendToTeacher: dataSend[1],
          ),
          studentOfEpisode.id!,
          selectedBehaviour!.name);
      listBehavioursOfStudent!.add(selectedBehaviour!.name);
      selectedBehaviour = null;
      uploadToServerChanged();
      responseContent = ResponseContent(statusCode: '200', success: true);
    } else {
      responseContent = await BehavioursService().addNewBehaviour(
          studentOfEpisode.planId!,
          selectedBehaviour!.id,
          dataSend[0],
          dataSend[1]);
      if (responseContent.isSuccess) {
        listBehavioursOfStudent!.add(selectedBehaviour!.name);
        selectedBehaviour = null;
      }
    }
    update();

    return responseContent;
  }

  String getTypePlanLine(String typePlanLine) {
    if (PlanLinesType.listen == typePlanLine) {
      return 'listen';
    } else if (PlanLinesType.reviewsmall == typePlanLine) {
      return 'review_small';
    } else if (PlanLinesType.reviewbig == typePlanLine) {
      return 'review_big';
    } else if (PlanLinesType.tlawa == typePlanLine) {
      return 'tlawa';
    }
    return '';
  }

  changeSelectedIndexBehaviour(Behaviour behaviour) {
    selectedBehaviour = behaviour;
    update();
  }

  changeSelectedIndexPeriod(Period period) {
    selectedPeriod = period;
    update();
  }

  changeSelectedIndexCenter(Center center) {
    selectedCenter = center;
    update();
  }

  // setter
  set currentIndex(int index) => {_currentIndex = index, update()};
  set currentPageIndex(int index) => {_currentPageIndex = index, update()};
  set gettingParks(bool val) => {_gettingEpisodes = val, update()};
  set hasError(bool val) => {_hasError = val, update()};
  set gettingStudentsOfEpisode(bool val) =>
      {_gettingStudentsOfEpisode = val, update()};
  set hasErrorStudentsOfEpisode(bool val) =>
      {_hasErrorStudentsOfEpisode = val, update()};
  set gettingPlanLines(bool val) => {_gettingPlanLines = val, update()};
  set hasErrorPlanLines(bool val) => {_hasErrorPlanLines = val, update()};
  set gettingEducationalPlan(bool val) =>
      {_gettingEducationalPlan = val, update()};
  set hasErrorEducationalPlan(bool val) =>
      {_hasErrorEducationalPlan = val, update()};
  set gettingBehaviours(bool val) => {_gettingBehaviours = val, update()};
  set hasErrorBehaviours(bool val) => {_hasErrorBehaviours = val, update()};
  set gettingNotifications(bool val) => {_gettingNotifications = val, update()};
  set hasErrorNotifications(bool val) =>
      {_hasErrorNotifications = val, update()};
  set gettingTest(bool val) => {_gettingTest = val, update()};
  set hasErrorTest(bool val) => {_hasErrorTest = val, update()};
  set gettingCalendarCenter(bool val) =>
      {_gettingCalendarCenter = val, update()};
  set hasErrorCalendarCenter(bool val) =>
      {_hasErrorCalendarCenter = val, update()};
  set gettingCenterTest(bool val) => {_gettingCenterTest = val, update()};
  set hasErrorCenterTest(bool val) => {_hasErrorCenterTest = val, update()};
  set isWorkLocal(bool val) => {_isWorkLocal = val, update()};

  //geter
  int get currentIndex => _currentIndex;
  int get currentPageIndex => _currentPageIndex;
  bool get gettingEpisodes => _gettingEpisodes;
  bool get hasError => _hasError;
  bool get gettingStudentsOfEpisode => _gettingStudentsOfEpisode;
  bool get hasErrorStudentsOfEpisode => _hasErrorStudentsOfEpisode;
  bool get gettingPlanLines => _gettingPlanLines;
  bool get hasErrorPlanLines => _hasErrorPlanLines;
  bool get gettingEducationalPlan => _gettingEducationalPlan;
  bool get hasErrorEducationalPlan => _hasErrorEducationalPlan;
  bool get gettingBehaviours => _gettingBehaviours;
  bool get hasErrorBehaviours => _hasErrorBehaviours;
  bool get gettingNotifications => _gettingNotifications;
  bool get hasErrorNotifications => _hasErrorNotifications;
  bool get gettingTest => _gettingTest;
  bool get hasErrorTest => _hasErrorTest;
  bool get gettingCalendarCenter => _gettingCalendarCenter;
  bool get hasErrorCalendarCenter => _hasErrorCalendarCenter;
  bool get gettingCenterTest => _gettingCenterTest;
  bool get hasErrorCenterTest => _hasErrorCenterTest;

  List<Episode> get listEpisodes => _listEpisodes;
  List<StudentOfEpisode> get listStudentsOfEpisode => _listStudentsOfEpisode;
  List<String>? get listBehavioursOfStudent => _listBehavioursOfStudent;
  List<Behaviour>? get listBehaviours => _listBehaviours;
  List<NotificationModel>? get listNotifications => _listNotifications;
  List<Center>? get listCenters => _listCenters;
  List<Period>? get listPeriods => _listPeriods;
  List<CalendarCenter>? get listCalendarCenter => _listCalendarCenter;
  List<CenterPreparType>? get listCenterPreparTypes => _listCenterPreparTypes;
  List<TestBranch>? get listTestbranchs => _listTestbranchs;
  bool get isWorkLocal => _isWorkLocal;
}
