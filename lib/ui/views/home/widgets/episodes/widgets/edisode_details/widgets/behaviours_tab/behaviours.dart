import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/behaviour/behaviour.dart';
import 'package:maknoon/model/core/episodes/student_of_episode.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/core/shared/status_and_types.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/utils/waitting_dialog.dart';
import 'package:maknoon/ui/shared/widgets/color_loader/color_loader.dart';

import 'widgets/confirm_add_behaviour.dart';
import 'widgets/select_behaviour.dart';

class Behaviours extends StatefulWidget {
  final StudentOfEpisode studentOfEpisode;
  final int selectIndex;
  const Behaviours({
    Key? key,
    required this.studentOfEpisode,required this.selectIndex,
  }) : super(key: key);

  @override
  State<Behaviours> createState() => _BehavioursState();
}

class _BehavioursState extends State<Behaviours> {

  List<String> listGeneralBehaviorType = [
    GeneralBehaviorType.excellent,
    GeneralBehaviorType.veryGood,
    GeneralBehaviorType.good,
    GeneralBehaviorType.accepted,
    GeneralBehaviorType.weak,
  ];
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    if (homeController.listBehavioursOfStudent == null) {
      homeController.loadBehaviours(widget.studentOfEpisode.id.toString(),
          isInit: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (HomeController homeController) => homeController
                .gettingBehaviours
            ? const Center(
                child: ColorLoader(),
              )
            : homeController.hasErrorBehaviours
                ? Center(
                    child: InkWell(
                    onTap: () {
                      homeController.loadBehaviours(
                          widget.studentOfEpisode.id.toString());
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
                          homeController.responseBehaviours.isErrorConnection
                              ? 'error_connect_to_netwotk'.tr
                              : 'error_connect_to_server'.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.4,
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
                : SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    'general_behavior'.tr,
                                    style: TextStyle(
                                        color: Get.theme.primaryColor,
                                        height: 1.4,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800),
                                    textScaleFactor:
                                        SizeConfig.textScaleFactor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    children: [
                                     Expanded(
                                        child: 
                                         PopupMenuButton<int>(
                                          padding: EdgeInsets.zero,

                                          child: Container(
                                            width: 130.w,
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
                                                            widget.selectIndex]
                                                        .generalBehaviorType
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
                                            ...listGeneralBehaviorType.map(
                                              (e) => PopupMenuItem(
                                                padding: EdgeInsets.zero,
                                                value: listGeneralBehaviorType
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
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500),
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
                                                        widget.selectIndex]
                                                    .generalBehaviorType
                                                    .tr !=
                                                listGeneralBehaviorType[value]
                                                    .tr) {
                                              ResponseContent response =
                                                  await showCupertinoDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          dialogContext) {
                                                        setGeneralBehavior(
                                                            listGeneralBehaviorType[
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
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]))),
                    SizedBox(
                      height: 20.h,
                    ),
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
                                          'behaviour_student'.tr,
                                          style: TextStyle(
                                              color: Get.theme.primaryColor,
                                              height: 1.4,
                                              fontSize: 14.sp,
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
                                    child: Row(
                                      children: [
                                        Text(
                                          '${'select_behaviour'.tr} : ',
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
                                              Behaviour? behaviour =
                                                  await showDialog(
                                                context: context,
                                                builder: (contextDialog) => const AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0))),
                                                    contentPadding:
                                                        EdgeInsets.all(1),
                                                    content: SelectBehaviour()),
                                              );
                                              if (behaviour != null) {
                                                if (behaviour !=
                                                    homeController
                                                        .selectedBehaviour) {
                                                  homeController
                                                      .changeSelectedIndexBehaviour(
                                                          behaviour);
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
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      homeController
                                                              .selectedBehaviour
                                                              ?.name ??
                                                          '',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                          height: 1.4,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textScaleFactor:
                                                          SizeConfig
                                                              .textScaleFactor,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  homeController.selectedBehaviour != null
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  List<bool>? dataSend =
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
                                                                ConfirmAddBehaviour()),
                                                  );
                                                  if (dataSend != null) {
                                                    ResponseContent response =
                                                        await showCupertinoDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                dialogContext) {
                                                              addBehavior(
                                                                  dataSend);
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
                                                          'ok_add_behavior'.tr;
                                                    } else if (!response
                                                        .isErrorConnection) {
                                                      response.message =
                                                          'error_add_behavior'
                                                              .tr;
                                                    }
                                                    CostomDailogs.snackBar(
                                                        response: response);
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30.w,
                                                      vertical: 10.h),
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Get.theme
                                                            .secondaryHeaderColor
                                                            .withOpacity(.5),
                                                        Get.theme
                                                            .secondaryHeaderColor,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
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
                                                      'save'.tr,
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
                                      : const SizedBox()
                                ],
                              ))
                            ]))),
                    SizedBox(
                      height: 20.h,
                    ),
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
                                          'note_behaviour_student'.tr,
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
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6.h, horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: Get.theme.secondaryHeaderColor
                                            .withOpacity(0.6),
                                        //  shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          homeController
                                                  .listBehavioursOfStudent!
                                                  .isEmpty
                                              ? Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'there_is_no_notes'.tr,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          height: 1.4,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textScaleFactor:
                                                            SizeConfig
                                                                .textScaleFactor,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : const SizedBox(),
                                          ...List.generate(
                                              homeController
                                                  .listBehavioursOfStudent!
                                                  .length,
                                              (index) => Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.h,
                                                            horizontal: 5.w),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            '${index + 1} - ${homeController.listBehavioursOfStudent![index]}',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              height: 1.4,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textScaleFactor:
                                                                SizeConfig
                                                                    .textScaleFactor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                        ],
                                      )),
                                ],
                              ))
                            ]))),
                  ])));
  }

  void addBehavior(List<bool> dataSend) async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent =
        await homeController.addBehavior(dataSend, widget.studentOfEpisode);
    Get.back(result: responseContent);
  }

  void setGeneralBehavior(String studentStateType) async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent = await homeController.setGeneralBehavior(
        studentStateType,
        homeController.listStudentsOfEpisode[widget.selectIndex].id!);
    Get.back(result: responseContent);
  }
}
