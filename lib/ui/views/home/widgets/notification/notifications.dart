import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/notification/notification_model.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/utils/waitting_dialog.dart';
import 'package:maknoon/ui/shared/widgets/color_loader/color_loader.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    if (homeController.listNotifications == null) {
      homeController.loadNotifications(
          homeController.userLogin!.teachId.toString(),
          isInit: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (HomeController homeController) => homeController
                .gettingNotifications
            ? const Center(
                child: ColorLoader(),
              )
            : homeController.hasErrorNotifications
                ? Center(
                    child: InkWell(
                    onTap: () {
                      homeController.loadNotifications(
                        homeController.userLogin!.teachId.toString(),
                      );
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
                          homeController.responseNotifications.isErrorConnection
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
                : homeController.listNotifications!.isNotEmpty
                    ? RefreshIndicator(
                    onRefresh: () async {
                      homeController.loadNotifications(
                        homeController.userLogin!.teachId.toString(),
                      );
                    },
                    child: ListView.separated(
                        itemBuilder: (_, index) => Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    const BorderSide(color: Colors.white)),
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, top: 10),
                            color: Colors.white,
                            child: ListTile(
                              onTap: (() async {
                                await notificationDetails(
                                    homeController
                                        .listNotifications![index],
                                    context);
                                ResponseContent notificationResponse =
                                    await showCupertinoDialog(
                                        context: context,
                                        builder:
                                            (BuildContext dialogContext) {
                                          consultNotification(homeController
                                              .listNotifications![index]
                                              .id);
                                          return WillPopScope(
                                            onWillPop: () async {
                                              return false;
                                            },
                                            child:
                                                const CupertinoAlertDialog(
                                              content: WaitingDialog(),
                                            ),
                                          );
                                        });
                                if (notificationResponse.isSuccess ||
                                    notificationResponse.isNoContent) {
                                  homeController.loadNotifications(
                                    homeController.userLogin!.teachId
                                        .toString(),
                                  );
                                } else {
                                  CostomDailogs.snackBar(
                                      response: notificationResponse);
                                }
                              }),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.w),
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  homeController.listNotifications![index]
                                              .state ==
                                          "draft"
                                      ? Icon(
                                          Icons.notifications_active,
                                          color: Get
                                              .theme.secondaryHeaderColor,
                                        )
                                      : const Icon(
                                          Icons.notifications_none),
                                ],
                              ),
                              title: Text(
                                homeController
                                    .listNotifications![index].name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              subtitle: Text(
                                homeController
                                    .listNotifications![index].description,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(.6),
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                            )),
                        separatorBuilder: (_, __) => const SizedBox(),
                        itemCount:
                            homeController.listNotifications!.length),
                      )
                    : Center(
                        child: Text(
                          'there_is_no_notifications'.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: SizeConfig.textScaleFactor,
                        ),
                      ));
  }

  void consultNotification(int notificationId) async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent = await homeController.consultNotification(
      notificationId,
    );
    Get.back(result: responseContent);
  }

  Future<void> notificationDetails(
      NotificationModel notification, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'notification_details'.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Get.theme.primaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: SizeConfig.textScaleFactor,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  notification.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: SizeConfig.textScaleFactor,
                ),
                Text(
                  notification.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: SizeConfig.textScaleFactor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '${'notification_date'.tr} : ${notification.dateNotification}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: SizeConfig.textScaleFactor,
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              child: Text(
                'ok'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Get.back(result: true);
              },
            ),
          ],
        );
      },
    );
  }
}
