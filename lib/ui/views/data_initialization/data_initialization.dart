import 'package:flutter/material.dart';
import 'package:maknoon/controller/data_sync_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';

class DataInitialization extends StatefulWidget {
  const DataInitialization({Key? key}) : super(key: key);

  @override
  State<DataInitialization> createState() => _DataInitializationState();
}

class _DataInitializationState extends State<DataInitialization> {
  @override
  void initState() {
    super.initState();
    // DataSyncController dataSyncController = Get.put(DataSyncController());
    // dataSyncController.loadDataSaveLocal(isOpenHomeScreen:true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GetBuilder(
            init: DataSyncController(isLoadDataSaveLocal: true),
            builder: (DataSyncController dataSyncController) =>
                dataSyncController.gettingEpisodes ||
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
                                        textScaleFactor:
                                            SizeConfig.textScaleFactor,
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
                                        textScaleFactor:
                                            SizeConfig.textScaleFactor,
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
                                          : dataSyncController
                                                      .gettingEpisodes ||
                                                  dataSyncController
                                                      .gettingPlanLines
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
                                        textScaleFactor:
                                            SizeConfig.textScaleFactor,
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
                                          : dataSyncController
                                                      .gettingEpisodes ||
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
                                        textScaleFactor:
                                            SizeConfig.textScaleFactor,
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
                              dataSyncController.loadDataSaveLocal(
                                  isOpenHomeScreen: true);
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
                                  (!dataSyncController.isEpisodesNotEmpty &&
                                          !dataSyncController.hasError)
                                      ? 'there_are_no_episodes_please_add_one_episode'.tr
                                      : (dataSyncController.hasError
                                              ? dataSyncController
                                                  .responseEpisodes
                                                  .isErrorConnection
                                              : dataSyncController
                                                      .hasErrorPlanLines
                                                  ? dataSyncController
                                                      .responsePlanLines
                                                      .isErrorConnection
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
                        : const SizedBox()),
      ),
    );
  }
}
