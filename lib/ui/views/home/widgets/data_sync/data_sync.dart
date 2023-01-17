import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maknoon/controller/data_sync_controller.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/utils/waitting_dialog.dart';

class DataSync extends StatefulWidget {
  const DataSync({Key? key}) : super(key: key);

  @override
  State<DataSync> createState() => _DataSyncState();
}

class _DataSyncState extends State<DataSync> {
  @override
  void initState() {
    super.initState();
    DataSyncController dataSyncController = Get.put(DataSyncController());
    dataSyncController.loadChangedDataLocal();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GetBuilder(
          init: DataSyncController(),
          builder: (DataSyncController dataSyncController) => dataSyncController
                      .gettingEpisodes ||
                  dataSyncController.gettingPlanLines ||
                  dataSyncController.gettingEducationalPlan ||
                  dataSyncController.gettingBehaviours
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      SvgPicture.asset(
                        'images/sync.svg',
                        height: 200.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'initializing_loading_data'.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: SizeConfig.textScaleFactor,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                dataSyncController.gettingEpisodes
                                    ? SizedBox(
                                        width: 30.w,
                                        height: 30.w,
                                        child: CircularProgressIndicator(
                                          color: Get.theme.primaryColor,
                                        ),
                                      )
                                    : Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 30.sp,
                                      ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  '${'episodes_and_students'.tr} ...',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: SizeConfig.textScaleFactor,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                dataSyncController.gettingPlanLines
                                    ? SizedBox(
                                        width: 30.w,
                                        height: 30.w,
                                        child: CircularProgressIndicator(
                                          color: Get.theme.primaryColor,
                                        ),
                                      )
                                    : dataSyncController.gettingEpisodes
                                        ? Icon(
                                            Icons.info,
                                            color: Colors.grey,
                                            size: 30.sp,
                                          )
                                        : Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 30.sp,
                                          ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  '${'student_courses'.tr} ...',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: SizeConfig.textScaleFactor,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                dataSyncController.gettingEducationalPlan
                                    ? SizedBox(
                                        width: 30.w,
                                        height: 30.w,
                                        child: CircularProgressIndicator(
                                          color: Get.theme.primaryColor,
                                        ),
                                      )
                                    : dataSyncController.gettingEpisodes ||
                                            dataSyncController.gettingPlanLines
                                        ? Icon(
                                            Icons.info,
                                            color: Colors.grey,
                                            size: 30.sp,
                                          )
                                        : Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 30.sp,
                                          ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  '${'educational_plan'.tr} ...',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: SizeConfig.textScaleFactor,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                dataSyncController.gettingBehaviours
                                    ? SizedBox(
                                        width: 30.w,
                                        height: 30.w,
                                        child: CircularProgressIndicator(
                                          color: Get.theme.primaryColor,
                                        ),
                                      )
                                    : dataSyncController.gettingEpisodes ||
                                            dataSyncController
                                                .gettingPlanLines ||
                                            dataSyncController
                                                .gettingEducationalPlan
                                        ? Icon(
                                            Icons.info,
                                            color: Colors.grey,
                                            size: 30.sp,
                                          )
                                        : Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 30.sp,
                                          ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  '${'behaviour'.tr} ...',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: SizeConfig.textScaleFactor,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ])
              : dataSyncController.hasError ||
                      dataSyncController.hasErrorPlanLines ||
                      dataSyncController.hasErrorEducationalPlan ||
                      dataSyncController.hasErrorBehaviours
                  ? Center(
                      child: InkWell(
                      onTap: () {
                        dataSyncController.loadDataSaveLocal();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Icon(Icons.refresh, color: Colors.red.shade700),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            (dataSyncController.hasError
                                    ? dataSyncController
                                        .responseEpisodes.isErrorConnection
                                    : dataSyncController.hasErrorPlanLines
                                        ? dataSyncController
                                            .responsePlanLines.isErrorConnection
                                        : dataSyncController
                                                .hasErrorEducationalPlan
                                            ? dataSyncController
                                                .responseEducationalPlan
                                                .isErrorConnection
                                            : dataSyncController
                                                .responseBehaviours
                                                .isErrorConnection)
                                ? 'error_connect_to_netwotk'.tr
                                : 'error_connect_to_server'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: SizeConfig.textScaleFactor,
                          ),
                        ],
                      ),
                    ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          dataSyncController.isWorkLocal
                              ? 'images/sync.svg'
                              : 'images/sync.svg',
                          height: 200.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          dataSyncController.isWorkLocal
                              ? dataSyncController.isNoChanges? 'there_are_no_changes_to_upload_to_the_server'.tr : 'uploadable_data_to_the_server'.tr
                              : 'activate_offline_work_and_data_synchronization'
                                  .tr,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.8,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          textScaleFactor: SizeConfig.textScaleFactor,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        dataSyncController.isWorkLocal
                            ? dataSyncController.gettingChangedData
                                ? CircularProgressIndicator(
                                    color: Get.theme.primaryColor,
                                  )
                                : SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Colors.white)),
                                            margin: EdgeInsets.only(
                                                top: 5.h, bottom: 5.h),
                                            color: Colors.white,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                    horizontal: 16.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'prepare_students'.tr,
                                                      style: TextStyle(
                                                          color: Get
                                                              .theme.primaryColor,
                                                          height: 1.4,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                    Text(
                                                      "${dataSyncController.countStudentState.toString()} ${'item'.tr}",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                  ],
                                                ))),
                                        Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Colors.white)),
                                            margin: EdgeInsets.only(
                                                top: 5.h, bottom: 5.h),
                                            color: Colors.white,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                    horizontal: 16.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'student_courses'.tr,
                                                      style: TextStyle(
                                                          color: Get
                                                              .theme.primaryColor,
                                                          height: 1.4,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                    Text(
                                                      "${dataSyncController.countListenLines.toString()} ${'item'.tr}",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                  ],
                                                ))),
                                        Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Colors.white)),
                                            margin: EdgeInsets.only(
                                                top: 5.h, bottom: 5.h),
                                            color: Colors.white,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                    horizontal: 16.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'general_behavior_students'
                                                          .tr,
                                                      style: TextStyle(
                                                          color: Get
                                                              .theme.primaryColor,
                                                          height: 1.4,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                    Text(
                                                      "${dataSyncController.countGeneralBehaviors.toString()} ${'item'.tr}",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                  ],
                                                ))),
                                        Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Colors.white)),
                                            margin: EdgeInsets.only(
                                                top: 5.h, bottom: 5.h),
                                            color: Colors.white,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.h,
                                                    horizontal: 16.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'behaviors_students'.tr,
                                                      style: TextStyle(
                                                          color: Get
                                                              .theme.primaryColor,
                                                          height: 1.4,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                    Text(
                                                      "${dataSyncController.countNewStudentBehaviours.toString()} ${'item'.tr}",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor: SizeConfig
                                                          .textScaleFactor,
                                                    ),
                                                  ],
                                                ))),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    ),
                                )
                            : const SizedBox(),
                        dataSyncController.isWorkLocal && dataSyncController.isNoChanges? const SizedBox():Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  if (dataSyncController.isWorkLocal) {
                                    ResponseContent response =
                                                  await showCupertinoDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          dialogContext) {
                                                        uploadToServer();
                                                        return WillPopScope(
                                                          onWillPop:
                                                              () async {
                                                            return false;
                                                          },
                                                          child:
                                                              const CupertinoAlertDialog(
                                                            content:
                                                                WaitingDialog(),
                                                          ),
                                                        );
                                                      });
                                              if (response.isSuccess ||
                                                  response.isNoContent) {
                                                setState(() {});
                                              } else if (!response
                                                  .isErrorConnection) {
                                                response.message =
                                                    'error_set_attendance'.tr;
                                                CostomDailogs.snackBar(
                                                    response: response);
                                              } else {
                                                CostomDailogs.snackBar(
                                                    response: response);
                                              }
                                    
                                  } else {
                                    dataSyncController.loadDataSaveLocal();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 15.h),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Get.theme.secondaryHeaderColor
                                            .withOpacity(.7),
                                        Get.theme.secondaryHeaderColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5, 5),
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      dataSyncController.isWorkLocal
                                          ? 'upload_data'.tr
                                          : 'activate'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textScaleFactor:
                                          SizeConfig.textScaleFactor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
    );
  }

   void uploadToServer() async {
    DataSyncController dataSyncController = Get.find<DataSyncController>();
    ResponseContent responseContent = await dataSyncController.uploadToServer();
    Get.back(result: responseContent);
  }
}
