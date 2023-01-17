import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/center_test/center_prepar_type.dart';
import 'package:maknoon/model/core/center_test/test_branch.dart';
import 'package:maknoon/model/core/episodes/student_of_episode.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/core/test/calendar_center.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/utils/waitting_dialog.dart';
import 'package:maknoon/ui/shared/widgets/color_loader/color_loader.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'center_test/widgets/select_center_prepar_type.dart';
import 'center_test/widgets/select_name_student.dart';
import 'center_test/widgets/select_test_branch.dart';

class CenterTest extends StatefulWidget {
  final CalendarCenter calendarCenter;
  final int studentId;
  final int episodeId;
  const CenterTest(
      {Key? key,
      required this.calendarCenter,
      required this.studentId,
      required this.episodeId})
      : super(key: key);

  @override
  State<CenterTest> createState() => _CenterTestState();
}

class _CenterTestState extends State<CenterTest> {
  List<String> trackks = ["من الناس", "من الفاتحة"];
  String? selectTrackk;
  late StudentOfEpisode selectStudentOfEpisode;
  CenterPreparType? selectCenterPreparType;
  TestBranch? selectTestBranch;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    homeController.claerDataCenterTest();
    homeController.loadCenterTest(widget.calendarCenter.centerId, isInit: true);
    selectStudentOfEpisode = homeController.listStudentsOfEpisode
        .firstWhere((element) => element.id == widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (HomeController homeController) => Scaffold(
            appBar: AppBar(
              backgroundColor: Get.theme.primaryColor,
              title: Text(
                'center_test'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w800),
                textScaleFactor: SizeConfig.textScaleFactor,
              ),
              titleSpacing: 2,
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Stack(children: [
              Positioned.fill(
                child: Image.asset(
                  'images/bgR2.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              Positioned.fill(
                child: homeController.gettingCenterTest
                    ? const Center(
                        child: ColorLoader(),
                      )
                    : homeController.hasErrorCenterTest
                        ? Center(
                            child: InkWell(
                            onTap: () {
                              homeController.loadCenterTest(
                                  widget.calendarCenter.centerId);
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
                                  homeController
                                          .responseCenterTest.isErrorConnection
                                      ? 'error_connect_to_netwotk'.tr
                                      : 'error_connect_to_server'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
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
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 10.w),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    color: Get.theme.secondaryHeaderColor
                                        .withOpacity(0.4),
                                    //  shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.calendarCenter.centerName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w500),
                                              textScaleFactor:
                                                  SizeConfig.textScaleFactor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat('E', 'ar').format(
                                                  DateTime.parse(widget
                                                      .calendarCenter.date)),
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                height: 1.4,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor:
                                                  SizeConfig.textScaleFactor,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Text(
                                                      '${'date'.tr} : ',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1.4,
                                                        color: Colors.black54,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor:
                                                          SizeConfig
                                                              .textScaleFactor,
                                                    ),
                                                    SizedBox(
                                                      width: 5.h,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        widget.calendarCenter
                                                            .date,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 1.4,
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textScaleFactor:
                                                            SizeConfig
                                                                .textScaleFactor,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Text(
                                                      '${'agree'.tr} : ',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1.4,
                                                        color: Colors.black54,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor:
                                                          SizeConfig
                                                              .textScaleFactor,
                                                    ),
                                                    SizedBox(
                                                      width: 5.h,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        HijriCalendar.fromDate(
                                                                DateTime.parse(
                                                                    widget
                                                                        .calendarCenter
                                                                        .date))
                                                            .toFormat(
                                                                "dd MMMM yyyy"),
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 1.4,
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textScaleFactor:
                                                            SizeConfig
                                                                .textScaleFactor,
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ]),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child: Text(
                                      //         widget.calendarCenter.date,
                                      //         style: TextStyle(
                                      //             color: Colors.black,
                                      //             fontSize: 14.sp,
                                      //             height: 1.4,
                                      //             fontWeight: FontWeight.w500),
                                      //         textScaleFactor:
                                      //             SizeConfig.textScaleFactor,
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //       child: Text(
                                      //         widget.calendarCenter.name,
                                      //         style: TextStyle(
                                      //             color: Colors.black,
                                      //             fontSize: 14.sp,
                                      //             height: 1.4,
                                      //             fontWeight: FontWeight.w500),
                                      //         textScaleFactor:
                                      //             SizeConfig.textScaleFactor,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          width: 2, color: Colors.white)),
                                  margin: EdgeInsets.only(
                                      left: 16.w,
                                      right: 16.w,
                                      top: 8.h,
                                      bottom: 8.h),
                                  color: Colors.white,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: Row(children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // Row(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.center,
                                            //   children: [
                                            //     SizedBox(
                                            //       width: 12.w,
                                            //     ),
                                            //     Expanded(
                                            //       child: Text(
                                            //         'studentـnomination'.tr,
                                            //         style: TextStyle(
                                            //             color: Get
                                            //                 .theme.primaryColor,
                                            //             fontSize: 14.sp,
                                            //             fontWeight:
                                            //                 FontWeight.w800),
                                            //         textScaleFactor: SizeConfig
                                            //             .textScaleFactor,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // SizedBox(
                                            //   height: 10.h,
                                            // ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 6.h,
                                                  horizontal: 10.w),
                                              decoration: BoxDecoration(
                                                color: Get
                                                    .theme.secondaryHeaderColor
                                                    .withOpacity(0.6),
                                                //  shape: BoxShape.circle,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${'name'.tr} : ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.sp,
                                                            height: 1.4,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        textScaleFactor:
                                                            SizeConfig
                                                                .textScaleFactor,
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            StudentOfEpisode?
                                                                studentOfEpisode =
                                                                await showDialog(
                                                              context: context,
                                                              builder: (contextDialog) => const AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              15.0))),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  content:
                                                                      SelectNameStudent()),
                                                            );
                                                            if (studentOfEpisode !=
                                                                null) {
                                                              if (studentOfEpisode !=
                                                                  selectStudentOfEpisode) {
                                                                setState(() {
                                                                  selectStudentOfEpisode =
                                                                      studentOfEpisode;
                                                                  selectTrackk =
                                                                      null;
                                                                  selectCenterPreparType =
                                                                      null;
                                                                  selectTestBranch =
                                                                      null;
                                                                });
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.h,
                                                                    horizontal:
                                                                        5.w),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.4),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    selectStudentOfEpisode
                                                                        .name,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 14
                                                                            .sp,
                                                                        height:
                                                                            1.4,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                    textScaleFactor:
                                                                        SizeConfig
                                                                            .textScaleFactor,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                                const Icon(Icons
                                                                    .keyboard_arrow_down_outlined)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  !selectStudentOfEpisode
                                                          .testRegister
                                                      ? Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${'type'.tr} : ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      height:
                                                                          1.4,
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  textScaleFactor:
                                                                      SizeConfig
                                                                          .textScaleFactor,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      CenterPreparType?
                                                                          newCenterPreparType =
                                                                          await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (contextDialog) => const AlertDialog(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                                                            contentPadding: EdgeInsets.all(10),
                                                                            content: SelectCenterPreparType()),
                                                                      );
                                                                      if (newCenterPreparType !=
                                                                          null) {
                                                                        if (newCenterPreparType !=
                                                                            selectCenterPreparType) {
                                                                          if (selectTrackk !=
                                                                              null) {
                                                                            ResponseContent response = await showCupertinoDialog(
                                                                                context: context,
                                                                                builder: (BuildContext dialogContext) {
                                                                                  getBranchs(selectTrackk!);
                                                                                  return WillPopScope(
                                                                                    onWillPop: () async {
                                                                                      return false;
                                                                                    },
                                                                                    child: const CupertinoAlertDialog(
                                                                                      content: WaitingDialog(),
                                                                                    ),
                                                                                  );
                                                                                });
                                                                            if (response.isSuccess ||
                                                                                response.isNoContent) {
                                                                              setState(() {
                                                                                selectCenterPreparType = newCenterPreparType;
                                                                                selectTestBranch = null;
                                                                              });
                                                                            } else if (!response.isErrorConnection) {
                                                                              response.message = 'error_get_branches'.tr;

                                                                              CostomDailogs.snackBar(response: response);
                                                                            }
                                                                          } else {
                                                                            setState(() {
                                                                              selectCenterPreparType = newCenterPreparType;
                                                                            });
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 5
                                                                              .h,
                                                                          horizontal:
                                                                              5.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              selectCenterPreparType?.parentName ?? '',
                                                                              style: TextStyle(color: Colors.black, height: 1.4, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                                                              textScaleFactor: SizeConfig.textScaleFactor,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 1,
                                                                            ),
                                                                          ),
                                                                          const Icon(
                                                                              Icons.keyboard_arrow_down_outlined)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${'path'.tr} : ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14.sp,
                                                                      height:
                                                                          1.4,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  textScaleFactor:
                                                                      SizeConfig
                                                                          .textScaleFactor,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      PopupMenuButton<
                                                                          int>(
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 5
                                                                              .h,
                                                                          horizontal:
                                                                              5.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              selectTrackk != null
                                                                                  ? selectTrackk == 'up'
                                                                                      ? trackks[0]
                                                                                      : trackks[1]
                                                                                  : '',
                                                                              style: TextStyle(color: Colors.black, height: 1.4, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                                                              textScaleFactor: SizeConfig.textScaleFactor,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 1,
                                                                            ),
                                                                          ),
                                                                          const Icon(
                                                                              Icons.keyboard_arrow_down_outlined)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    itemBuilder:
                                                                        (context) =>
                                                                            [
                                                                      PopupMenuItem(
                                                                        value:
                                                                            0,
                                                                        height:
                                                                            20.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            trackks[0],
                                                                            style: const TextStyle(
                                                                                decoration: TextDecoration.none,
                                                                                color: Colors.black,
                                                                                height: 1.4,
                                                                                fontWeight: FontWeight.w500),
                                                                            textScaleFactor:
                                                                                SizeConfig.textScaleFactor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const PopupMenuDivider(),
                                                                      PopupMenuItem(
                                                                        value:
                                                                            1,
                                                                        height:
                                                                            20.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            trackks[1],
                                                                            style: const TextStyle(
                                                                                decoration: TextDecoration.none,
                                                                                color: Colors.black,
                                                                                height: 1.4,
                                                                                fontWeight: FontWeight.w500),
                                                                            textScaleFactor:
                                                                                SizeConfig.textScaleFactor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    onSelected:
                                                                        (value) async {
                                                                      if (selectTrackk !=
                                                                          trackks[
                                                                              value]) {
                                                                        ResponseContent response = await showCupertinoDialog(
                                                                            context: context,
                                                                            builder: (BuildContext dialogContext) {
                                                                              getBranchs(value == 0 ? 'up' : 'down');
                                                                              return WillPopScope(
                                                                                onWillPop: () async {
                                                                                  return false;
                                                                                },
                                                                                child: const CupertinoAlertDialog(
                                                                                  content: WaitingDialog(),
                                                                                ),
                                                                              );
                                                                            });
                                                                        if (response.isSuccess ||
                                                                            response.isNoContent) {
                                                                          setState(
                                                                              () {
                                                                            selectTrackk = value == 0
                                                                                ? 'up'
                                                                                : 'down';
                                                                          });
                                                                        } else if (!response
                                                                            .isErrorConnection) {
                                                                          response.message =
                                                                              'error_get_branches'.tr;
                                                                          CostomDailogs.snackBar(
                                                                              response: response);
                                                                        }
                                                                      }
                                                                    },
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${'branch'.tr} : ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14.sp,
                                                                      height:
                                                                          1.4,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  textScaleFactor:
                                                                      SizeConfig
                                                                          .textScaleFactor,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      if (selectCenterPreparType !=
                                                                              null &&
                                                                          selectTrackk !=
                                                                              null) {
                                                                        TestBranch?
                                                                            newTestBranch =
                                                                            await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (contextDialog) => const AlertDialog(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                                                              content: SelectTestBranch()),
                                                                        );
                                                                        if (newTestBranch !=
                                                                            null) {
                                                                          if (newTestBranch !=
                                                                              selectTestBranch) {
                                                                            setState(() {
                                                                              selectTestBranch = newTestBranch;
                                                                            });
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 5
                                                                              .h,
                                                                          horizontal:
                                                                              5.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              selectTestBranch?.branchName ?? '',
                                                                              style: TextStyle(color: Colors.black, height: 1.4, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                                                              textScaleFactor: SizeConfig.textScaleFactor,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 1,
                                                                            ),
                                                                          ),
                                                                          const Icon(
                                                                              Icons.keyboard_arrow_down_outlined)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      ResponseContent response =
                                                          await showCupertinoDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                  dialogContext) {
                                                                !selectStudentOfEpisode
                                                                        .testRegister
                                                                    ? addStudentTestSession()
                                                                    : cancelStudentTestSession();
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
                                                      if (response.isSuccess) {
                                                        response.message =
                                                            !selectStudentOfEpisode
                                                                    .testRegister
                                                                ? 'ok_registration'
                                                                    .tr
                                                                : 'ok_unregister'
                                                                    .tr;
                                                        CostomDailogs.snackBar(
                                                            response: response);
                                                        setState(() {
                                                          selectStudentOfEpisode =
                                                              homeController
                                                                  .listStudentsOfEpisode
                                                                  .firstWhere((element) =>
                                                                      element
                                                                          .id ==
                                                                      widget
                                                                          .studentId);
                                                        });
                                                      } else if (!response
                                                          .isErrorConnection) {
                                                        // response.message =
                                                        //     !selectStudentOfEpisode
                                                        //             .testRegister
                                                        //         ? 'error_registration'.tr
                                                        //         : 'error_unregister'.tr;
                                                        CostomDailogs
                                                            .warringDialogWithGet(
                                                                msg: response
                                                                    .message!);
                                                      } else {
                                                        CostomDailogs.snackBar(
                                                            response: response);
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 30.w,
                                                              vertical: 10.h),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Get.theme
                                                                .secondaryHeaderColor
                                                                .withOpacity(
                                                                    .5),
                                                            Get.theme
                                                                .secondaryHeaderColor,
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            offset:
                                                                Offset(5, 5),
                                                            blurRadius: 10,
                                                          )
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          !selectStudentOfEpisode
                                                                  .testRegister
                                                              ? 'registration'
                                                                  .tr
                                                              : 'unregister'.tr,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.sp,
                                                            height: 1.4,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textScaleFactor:
                                                              SizeConfig
                                                                  .textScaleFactor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ))
                                      ]))),
                            ],
                          ),
              )
            ]))));
  }

  void getBranchs(String trackk) async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent = await homeController.getTestbranchs(
        selectCenterPreparType!.parentId, trackk);
    Get.back(result: responseContent);
  }

  void addStudentTestSession() async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent =
        await homeController.addStudentTestSession(
            selectStudentOfEpisode.id!,
            selectTestBranch!.branchId,
            selectCenterPreparType!.parentId,
            widget.calendarCenter.id,
            selectTrackk!,
            widget.episodeId);
    Get.back(result: responseContent);
  }

  void cancelStudentTestSession() async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent =
        await homeController.cancelStudentTestSession(
            selectStudentOfEpisode.sessionId!, widget.episodeId);
    Get.back(result: responseContent);
  }
}
