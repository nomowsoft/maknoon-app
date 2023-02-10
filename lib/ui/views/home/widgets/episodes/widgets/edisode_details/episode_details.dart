import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/episodes/episode.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/core/shared/status_and_types.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/utils/waitting_dialog.dart';
import 'package:maknoon/ui/shared/widgets/buttons/custom_list_button_underlined.dart';
import 'package:maknoon/ui/shared/widgets/color_loader/color_loader.dart';
import 'widgets/behaviours_tab/behaviours.dart';
import 'widgets/educational_plan_tab/educational_plan.dart';
import 'widgets/follow_up_tab.dart/follow_up.dart';
import 'widgets/test_tab/test.dart';

class EpisodeDetails extends StatefulWidget {
  final Episode episode;
  const EpisodeDetails({Key? key, required this.episode}) : super(key: key);

  @override
  State<EpisodeDetails> createState() => _EpisodeDetailsState();
}

class _EpisodeDetailsState extends State<EpisodeDetails> {
  int selectIndex = 0;
  int indextab = 0;
  List<String> tabs = [
    'follow_up'.tr,
    'behaviour'.tr,
    'educational_plan'.tr,
    'ترشيح الطالب للاختبارات'
  ];
  List<String> listStudentStateType = [
    StudentStateType.present,
    StudentStateType.absent,
    StudentStateType.absentExcuse,
    StudentStateType.notRead,
    StudentStateType.excuse,
    StudentStateType.delay,
  ];
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    homeController.initStudntData();
    homeController.loadStudentsOfEpisode(widget.episode.id.toString(),
        isInit: true);
    Future.delayed(const Duration(seconds: 2), () {
      homeController.checkStudents(widget.episode.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController homeController) => Scaffold(
          appBar: AppBar(
            backgroundColor: Get.theme.primaryColor,
            title: Text(
              widget.episode.displayName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800),
              textScaleFactor: SizeConfig.textScaleFactor,
            ),
            titleSpacing: 2,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: (() {
                  Get.back();
                }),
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          drawerEnableOpenDragGesture:
              !homeController.gettingStudentsOfEpisode &&
                  !homeController.hasErrorStudentsOfEpisode,
          drawer: Drawer(
              backgroundColor: Get.theme.primaryColor,
              child: SafeArea(
                child: OrientationBuilder(builder: (context, orientation) {
                  SizeConfig('initialSize')
                      .init(originalWidth: 428, originalHeight: 926);

                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'images/bgR2.png',
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                      Positioned.fill(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 15.w),
                                decoration: const BoxDecoration(
                                  color: Color(0xffF1F1F1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Get.theme.secondaryHeaderColor,
                                  size: 35,
                                )),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              widget.episode.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                              textScaleFactor: SizeConfig.textScaleFactor,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Divider(
                                color: Colors.white,
                                indent: 20.w,
                                endIndent: 20.w),
                            SizedBox(
                              height: 20.h,
                            ),
                            Expanded(
                                child: ListView.separated(
                                    itemBuilder: (_, index) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectIndex = index;
                                            });
                                            homeController.initStudntData();
                                            // homeController.getStudentStateToDayLocal(homeController
                                            //           .listStudentsOfEpisode[
                                            //               index]
                                            //           .planId!);
                                            if (indextab == 0) {
                                              homeController.loadPlanLines(
                                                  widget.episode.id.toString(),
                                                  homeController
                                                      .listStudentsOfEpisode[
                                                          index]
                                                      .studentId
                                                      .toString());
                                            } else if (indextab == 1) {
                                              homeController.loadBehaviours(
                                                  homeController
                                                      .listStudentsOfEpisode[
                                                          index]
                                                      .id
                                                      .toString());
                                            } else if (indextab == 2) {
                                              homeController.loadEducationalPlan(
                                                  widget.episode.id.toString(),
                                                  homeController
                                                      .listStudentsOfEpisode[
                                                          index]
                                                      .studentId
                                                      .toString());
                                            } else if (indextab == 3) {
                                              homeController.loadTest(
                                                widget.episode.id,
                                              );
                                            }
                                            Get.back();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                                horizontal: 10.w),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                                horizontal: 10.w),
                                            decoration: BoxDecoration(
                                              color: Get
                                                  .theme.secondaryHeaderColor
                                                  .withOpacity(
                                                      selectIndex == index
                                                          ? 0.7
                                                          : 0.4),
                                              //  shape: BoxShape.circle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      homeController
                                                          .listStudentsOfEpisode[
                                                              index]
                                                          .name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textScaleFactor:
                                                          SizeConfig
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 6.h,
                                                            horizontal: 10.w),
                                                    decoration: BoxDecoration(
                                                      color: Get.theme
                                                          .secondaryHeaderColor,
                                                      //  shape: BoxShape.circle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      homeController
                                                          .listStudentsOfEpisode[
                                                              index]
                                                          .state
                                                          .tr,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textScaleFactor:
                                                          SizeConfig
                                                              .textScaleFactor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(),
                                    itemCount: homeController
                                        .listStudentsOfEpisode.length)),
                          ],
                        ),
                      )),
                      // ListView(
                      //   // Important: Remove any padding from the ListView.
                      //   padding: EdgeInsets.zero,
                      //   children: [
                      //     UserAccountsDrawerHeader(
                      //       // <-- SEE HERE
                      //       decoration:
                      //           BoxDecoration(color: Get.theme.primaryColor),
                      //       accountName: Text(
                      //         homeController.userLogin?.displayName ?? '',
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w500),
                      //         textScaleFactor: SizeConfig.textScaleFactor,
                      //       ),

                      //       currentAccountPicture: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           SvgPicture.asset(
                      //             'images/maknoon_icon.svg',
                      //             height: 100.h,
                      //           ),
                      //           SizedBox(
                      //             height: 10.h,
                      //           ),
                      //           Container(
                      //               padding: EdgeInsets.symmetric(
                      //                   horizontal: 10.w, vertical: 10.w),
                      //               decoration: const BoxDecoration(
                      //                 color: Color(0xffF1F1F1),
                      //                 shape: BoxShape.circle,
                      //               ),
                      //               child: Icon(
                      //                 Icons.person,
                      //                 color: Get.theme.secondaryHeaderColor,
                      //                 size: 25,
                      //               )),
                      //         ],
                      //       ),
                      //       accountEmail: null,
                      //     ),
                      //     ListTile(
                      //       leading: const Icon(
                      //         Icons.menu_open,
                      //       ),
                      //       title: const Text('قائمة المصطلحات'),
                      //       onTap: () {
                      //         Get.back();
                      //         // Get.to(() => const GlossaryOfTerms());
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  );
                }),
              )),
          body: SafeArea(
              child: Stack(children: [
            Positioned.fill(
              child: Image.asset(
                'images/bgR2.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
            Positioned.fill(
                child: homeController.gettingStudentsOfEpisode
                    ? const Center(
                        child: ColorLoader(),
                      )
                    : homeController.hasErrorStudentsOfEpisode
                        ? Center(
                            child: InkWell(
                            onTap: () {
                              homeController.loadStudentsOfEpisode(
                                  widget.episode.id.toString());
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
                                  homeController.responseStudentsOfEpisode
                                          .isErrorConnection
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
                            children: [
                              Container(
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
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 15.w),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffF1F1F1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: Get.theme.secondaryHeaderColor,
                                          size: 35,
                                        )),
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeController
                                                .listStudentsOfEpisode[
                                                    selectIndex]
                                                .name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                height: 1.3,
                                                fontWeight: FontWeight.w500),
                                            textScaleFactor:
                                                SizeConfig.textScaleFactor,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          PopupMenuButton<int>(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              width: 150.w,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 10.w),
                                              decoration: BoxDecoration(
                                                color: Get
                                                    .theme.secondaryHeaderColor,
                                                //  shape: BoxShape.circle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      homeController
                                                          .listStudentsOfEpisode[
                                                              selectIndex]
                                                          .state
                                                          .tr,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      maxLines: 1,
                                                      textScaleFactor:
                                                          SizeConfig
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 25.sp,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                            itemBuilder: (context) => [
                                              ...listStudentStateType.map(
                                                (e) => PopupMenuItem(
                                                  padding: EdgeInsets.zero,
                                                  value: listStudentStateType
                                                      .indexOf(e),
                                                  height: 50.h,
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          e.tr,
                                                          style: const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textScaleFactor:
                                                              SizeConfig
                                                                  .textScaleFactor,
                                                        ),
                                                      ),
                                                      // Divider(height: 20.h,thickness: 1.5,)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                            onSelected: (value) async {
                                              if (homeController
                                                      .listStudentsOfEpisode[
                                                          selectIndex]
                                                      .state
                                                      .tr !=
                                                  listStudentStateType[value]
                                                      .tr) {
                                                ResponseContent response =
                                                    await showCupertinoDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            dialogContext) {
                                                          setAttendance(
                                                              listStudentStateType[
                                                                  value]);
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
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                color: Colors.white,
                                height: 50,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) =>
                                        CustomListButtonUnderlined(
                                          text: tabs[index],
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
                                    itemCount: tabs.length),
                              ),
                              Expanded(
                                  child: indextab == 0
                                      ? FollowUp(
                                          episode: widget.episode,
                                          studentId: homeController
                                              .listStudentsOfEpisode[
                                                  selectIndex]
                                              .studentId!,
                                          planId: homeController
                                              .listStudentsOfEpisode[
                                                  selectIndex]
                                              .planId!,
                                          id: homeController
                                              .listStudentsOfEpisode[
                                                  selectIndex]
                                              .id!,
                                        )
                                      : indextab == 1
                                          ? Behaviours(
                                              studentOfEpisode: homeController
                                                      .listStudentsOfEpisode[
                                                  selectIndex],
                                              selectIndex: selectIndex)
                                          : indextab == 2
                                              ? EducationalPlan(
                                                  episode: widget.episode,
                                                  studentId: homeController
                                                      .listStudentsOfEpisode[
                                                          selectIndex]
                                                      .studentId!)
                                              : indextab == 3
                                                  ? TestTab(
                                                      episode: widget.episode,
                                                      studentId: homeController
                                                          .listStudentsOfEpisode[
                                                              selectIndex]
                                                          .id!,
                                                    )
                                                  : const SizedBox())
                            ],
                          )),
          ]))),
    );
  }

  void setAttendance(String studentStateType) async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent = await homeController.setAttendance(
        homeController.listStudentsOfEpisode[selectIndex].planId!,
        studentStateType,
        homeController.listStudentsOfEpisode[selectIndex].id!);
    Get.back(result: responseContent);
  }
}
// tabs[index]