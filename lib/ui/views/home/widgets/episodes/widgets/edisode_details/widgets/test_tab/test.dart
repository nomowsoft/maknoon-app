import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/episodes/episode.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/core/test/calendar_center.dart';
import 'package:maknoon/model/core/test/period.dart';
import 'package:maknoon/ui/shared/widgets/color_loader/color_loader.dart';
import 'package:maknoon/model/core/test/center.dart' as center;
import 'widgets/center_test.dart';
import 'widgets/select_center.dart';
import 'widgets/select_period.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class TestTab extends StatefulWidget {
  final Episode episode;
  final int studentId;
  const TestTab({Key? key, required this.episode, required this.studentId})
      : super(key: key);

  @override
  State<TestTab> createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    HijriCalendar.setLocal('ar');
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    if (homeController.listPeriods == null) {
      homeController.loadTest(widget.episode.id, isInit: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (HomeController homeController) => homeController.gettingTest
            ? const Center(
                child: ColorLoader(),
              )
            : homeController.hasErrorTest
                ? Center(
                    child: InkWell(
                    onTap: () {
                      homeController.loadTest(widget.episode.id);
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
                          homeController.responseTest.isErrorConnection
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
                : Column(mainAxisSize: MainAxisSize.max, children: [
                    Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                                width: 2, color: Colors.white)),
                        margin: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                        color: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'studentـnomination'.tr,
                                          style: TextStyle(
                                              color: Get.theme.primaryColor,
                                              fontSize: 14.sp,
                                              height: 1.4,
                                              fontWeight: FontWeight.w800),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      color: Get.theme.secondaryHeaderColor
                                          .withOpacity(0.6),
                                      //  shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${'select_period'.tr} : ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w500),
                                              textScaleFactor:
                                                  SizeConfig.textScaleFactor,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  Period? period =
                                                      await showDialog(
                                                    context: context,
                                                    builder: (contextDialog) =>
                                                        const AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0))),
                                                    contentPadding:
                                                        EdgeInsets.all(15),
                                                            content:
                                                                SelectPeriod()),
                                                  );
                                                  if (period != null) {
                                                    if (period !=
                                                        homeController
                                                            .selectedPeriod) {
                                                      homeController
                                                          .changeSelectedIndexPeriod(
                                                              period);
                                                      if (homeController
                                                              .selectedCenter !=
                                                          null) {
                                                        homeController.loadCalendarCenter(
                                                            homeController
                                                                .selectedCenter!
                                                                .id,
                                                            widget.episode.id,
                                                            period.id);
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5.h,
                                                      horizontal: 5.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          homeController
                                                                  .selectedPeriod
                                                                  ?.name ??
                                                              '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              height: 1.4,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textScaleFactor:
                                                              SizeConfig
                                                                  .textScaleFactor,
                                                          overflow: TextOverflow
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
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${'select_center'.tr} : ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w500),
                                              textScaleFactor:
                                                  SizeConfig.textScaleFactor,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  center.Center? newCenter =
                                                      await showDialog(
                                                    context: context,
                                                    builder: (contextDialog) =>
                                                        const AlertDialog(

                                                            shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0))),
                                                    contentPadding:
                                                        EdgeInsets.all(15),
                                                            content:
                                                                SelectCenter()),
                                                  );
                                                  if (newCenter != null) {
                                                    if (newCenter !=
                                                        homeController
                                                            .selectedCenter) {
                                                      homeController
                                                          .changeSelectedIndexCenter(
                                                              newCenter);
                                                      if (homeController
                                                              .selectedPeriod !=
                                                          null) {
                                                        homeController
                                                            .loadCalendarCenter(
                                                                newCenter.id,
                                                                widget
                                                                    .episode.id,
                                                                homeController
                                                                    .selectedPeriod!
                                                                    .id);
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5.h,
                                                      horizontal: 5.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          homeController
                                                                  .selectedCenter
                                                                  ?.name ??
                                                              '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              height: 1.4,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textScaleFactor:
                                                              SizeConfig
                                                                  .textScaleFactor,
                                                          overflow: TextOverflow
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
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                            ]))),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                        child: homeController.gettingCalendarCenter
                            ? const Center(
                                child: ColorLoader(),
                              )
                            : homeController.hasErrorCalendarCenter
                                ? Center(
                                    child: InkWell(
                                    onTap: () {
                                      homeController.loadCalendarCenter(
                                          homeController.selectedCenter!.id,
                                          widget.episode.id,
                                          homeController.selectedPeriod!.id);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Icon(Icons.refresh,
                                            color: Colors.red.shade700),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          homeController.responseCalendarCenter
                                                  .isErrorConnection
                                              ? 'error_connect_to_netwotk'.tr
                                              : 'error_connect_to_server'.tr,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            height: 1.4,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                      ],
                                    ),
                                  ))
                                : homeController.listCalendarCenter != null
                                    ? homeController
                                            .listCalendarCenter!.isNotEmpty
                                        ? ListView.separated(
                                            itemBuilder: (_, index) => item(
                                                homeController
                                                        .listCalendarCenter![
                                                    index]),
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(),
                                            itemCount: homeController
                                                .listCalendarCenter!.length)
                                        : Center(
                                            child: Text(
                                              'there_is_no_calendarCenter'.tr,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                height: 1.4,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor:
                                                  SizeConfig.textScaleFactor,
                                            ),
                                          )
                                    : const SizedBox())
                  ]));
  }

  Widget item(CalendarCenter calendarCenter) {
    return InkWell(
      onTap: () {
        Get.to(() => CenterTest(
              calendarCenter: calendarCenter,
              studentId: widget.studentId,
              episodeId: widget.episode.id,
            ));
      },
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(width: 2, color: Colors.white)),
          margin:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h, bottom: 5.h),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    DateFormat('E','ar').format(DateTime.parse(calendarCenter.date)),
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: SizeConfig.textScaleFactor,
                  ),
                 SizedBox(height: 10.h,),
                  Row(children: [
                    Expanded(child: Row(children: [
                       Text(
                    '${'date'.tr} : ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: SizeConfig.textScaleFactor,
                  ),
                  SizedBox(width: 5.h,),
                   Expanded(
                     child: Text(
                      calendarCenter.date,
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
                   ),
                    ],)),
                  
                    Expanded(child: Row(children: [
                       Text(
                    '${'agree'.tr} : ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: SizeConfig.textScaleFactor,
                  ),
                  SizedBox(width: 5.h,),
                   Expanded(
                     child: Text(
                      HijriCalendar.fromDate(DateTime.parse(calendarCenter.date)).toFormat("dd MMMM yyyy"),
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
                   ),
                    ],))
                  
                  ],),
                 
                  
                  
                ]),
          )),
    );
  }
}
