import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/educational/educational.dart';
import 'package:maknoon/model/core/episodes/episode.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maknoon/model/core/shared/status_and_types.dart';
import 'package:maknoon/ui/shared/widgets/buttons/custom_list_button_underlined.dart';
import 'package:maknoon/ui/shared/widgets/color_loader/color_loader.dart';

class EducationalPlan extends StatefulWidget {
  final Episode episode;
  final int studentId;
  const EducationalPlan(
      {Key? key, required this.episode, required this.studentId})
      : super(key: key);

  @override
  State<EducationalPlan> createState() => _EducationalPlanState();
}

class _EducationalPlanState extends State<EducationalPlan> {
  int indextab = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    if (homeController.educationalPlan == null) {
      homeController.loadEducationalPlan(
          widget.episode.id.toString(), widget.studentId.toString(),
          isInit: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController homeController) => homeController
              .gettingEducationalPlan
          ? const Center(
              child: ColorLoader(),
            )
          : homeController.hasErrorEducationalPlan
              ? Center(
                  child: InkWell(
                  onTap: () {
                    homeController.loadEducationalPlan(
                        widget.episode.id.toString(),
                        widget.studentId.toString());
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
                        homeController.responseEducationalPlan.isErrorConnection
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
              : getLisTabs().isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 50,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) =>
                                  CustomListButtonUnderlined(
                                    text: getLisTabs()[index].tr,
                                    isSelected: indextab == index,
                                    onPressed: () {
                                      setState(() {
                                        indextab = index;
                                      });
                                    },
                                  ),
                              separatorBuilder: (_, __) => const SizedBox(
                                    width: 10,
                                  ),
                              itemCount: getLisTabs().length),
                        ),
                        Expanded(
                            child: ListView.separated(
                                itemBuilder: (_, index) =>
                                    item(getList(indextab)[index]),
                                separatorBuilder: (_, __) => const SizedBox(),
                                itemCount: getList(indextab).length)),
                      ],
                    )
                  : const SizedBox(),
    );
  }

  List<Educational> getList(int tabIndex) {
    HomeController homeController = Get.find<HomeController>();
    String tab = getLisTabs()[tabIndex];
    if (tab == PlanLinesType.listen) {
      return homeController.educationalPlan!.planListen;
    }
    if (tab == PlanLinesType.reviewsmall) {
      return homeController.educationalPlan!.planReviewSmall;
    }
    if (tab == PlanLinesType.reviewbig) {
      return homeController.educationalPlan!.planReviewbig;
    } else {
      return homeController.educationalPlan!.planTlawa;
    }
  }

  List<String> getLisTabs() {
    HomeController homeController = Get.find<HomeController>();
    List<String> tabs = [];
    if (homeController.educationalPlan!.planListen.isNotEmpty) {
      tabs.add(PlanLinesType.listen);
    }
    if (homeController.educationalPlan!.planReviewSmall.isNotEmpty) {
      tabs.add(PlanLinesType.reviewsmall);
    }
    if (homeController.educationalPlan!.planReviewbig.isNotEmpty) {
      tabs.add(PlanLinesType.reviewbig);
    }
    if (homeController.educationalPlan!.planTlawa.isNotEmpty) {
      tabs.add(PlanLinesType.tlawa);
    }
    return tabs;
  }

  Card item(Educational educational) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(width: 2, color: Colors.white)),
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          padding: EdgeInsets.symmetric(
                              vertical: 6.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            color:
                                Get.theme.secondaryHeaderColor.withOpacity(0.6),
                            //  shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'course'.tr,
                                    style: TextStyle(
                                        color: Get.theme.primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800),
                                    textScaleFactor: SizeConfig.textScaleFactor,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${'date'.tr} : ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        textScaleFactor:
                                            SizeConfig.textScaleFactor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        educational.actualDate != null
                                            ? getDateTimeName(
                                                educational.actualDate!)
                                            : 'there_is_no'.tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w800),
                                        textScaleFactor:
                                            SizeConfig.textScaleFactor,
                                      ),
                                    ],
                                  ),
                                ],
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
                                          '${'from_sura'.tr} : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            educational.fromSuraName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            textScaleFactor:
                                                SizeConfig.textScaleFactor,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          '${'to_sura'.tr} : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            educational.toSuraName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            textScaleFactor:
                                                SizeConfig.textScaleFactor,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                                          '${'from_aya'.tr} : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          educational.fromAya.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          '${'to_aya'.tr} : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          educational.toAya.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          padding: EdgeInsets.symmetric(
                              vertical: 6.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            color:
                                Get.theme.secondaryHeaderColor.withOpacity(0.6),
                            //  shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notes'.tr,
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800),
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'save_errors'.tr,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          educational.totalMstkQty.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'intonation_errors'.tr,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          educational.totalMstkRead.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor:
                                              SizeConfig.textScaleFactor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // SizedBox(
                        //   height: 5.h,
                        // ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 12.w),
                        //   padding: EdgeInsets.symmetric(
                        //       vertical: 6.h, horizontal: 10.w),
                        //   decoration: BoxDecoration(
                        //     color:
                        //         Get.theme.secondaryHeaderColor.withOpacity(0.6),
                        //     //  shape: BoxShape.circle,
                        //     borderRadius: BorderRadius.circular(5),
                        //   ),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child: Column(
                        //               children: [
                        //                 Text(
                        //                   'date_planned'.tr,
                        //                   style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: 14.sp,
                        //                       fontWeight: FontWeight.w500),
                        //                   textScaleFactor:
                        //                       SizeConfig.textScaleFactor,
                        //                 ),
                        //                 SizedBox(
                        //                   height: 7.h,
                        //                 ),
                        //                 Text(
                        //                   educational.plannedDate != null
                        //                       ? getDateTimeName(
                        //                           educational.plannedDate!)
                        //                       : '',
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 14.sp,
                        //                       fontWeight: FontWeight.w800),
                        //                   textScaleFactor:
                        //                       SizeConfig.textScaleFactor,
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 5.w,
                        //           ),
                        //           Expanded(
                        //             child: Column(
                        //               children: [
                        //                 Text(
                        //                   'actual_date'.tr,
                        //                   style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: 14.sp,
                        //                       fontWeight: FontWeight.w500),
                        //                   textScaleFactor:
                        //                       SizeConfig.textScaleFactor,
                        //                 ),
                        //                 SizedBox(
                        //                   height: 7.h,
                        //                 ),
                        //                 Text(
                        //                   educational.actualDate != null
                        //                       ? getDateTimeName(
                        //                           educational.actualDate!)
                        //                       : '',
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 14.sp,
                        //                       fontWeight: FontWeight.w800),
                        //                   textScaleFactor:
                        //                       SizeConfig.textScaleFactor,
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 5.w,
                        //           ),
                        //           Expanded(
                        //             child: Column(
                        //               children: [
                        //                 Text(
                        //                   'difference_date'.tr,
                        //                   style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: 14.sp,
                        //                       fontWeight: FontWeight.w500),
                        //                   textScaleFactor:
                        //                       SizeConfig.textScaleFactor,
                        //                 ),
                        //                 SizedBox(
                        //                   height: 7.h,
                        //                 ),
                        //                 Text(
                        //                   educational.actualDate != null &&
                        //                           educational.plannedDate !=
                        //                               null
                        //                       ? educational.actualDate!
                        //                           .difference(
                        //                               educational.plannedDate!)
                        //                           .inDays
                        //                           .toString() + ' ${'day'.tr} '
                        //                       : '',
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 14.sp,
                        //                       fontWeight: FontWeight.w500),
                        //                   textScaleFactor:
                        //                       SizeConfig.textScaleFactor,
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ]),
                ),
              ],
            )));
  }

  String getDateTimeName(DateTime dateTime) {
    return DateFormat('yMd', 'ar').format(dateTime);
  }
}
