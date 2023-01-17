import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maknoon/controller/data_sync_controller.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maknoon/model/services/user_service.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/views/home/widgets/about_us/about_us.dart';
import 'package:maknoon/ui/views/home/widgets/complaints/complaints.dart';
import 'package:maknoon/ui/views/home/widgets/data_sync/data_sync.dart';
import 'package:maknoon/ui/views/home/widgets/notification/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../user/login.dart';
import 'widgets/episodes/episodes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController homeController) => Scaffold(
          appBar: AppBar(
            backgroundColor: Get.theme.primaryColor,
            title: Text(
              homeController.currentPageIndex == 1
                  ? 'maknoon'.tr
                  : homeController.currentPageIndex == 2
                      ? 'notifications'.tr
                      : homeController.currentPageIndex == 3
                          ? 'synchronization'.tr
                          : homeController.currentPageIndex == 4
                              ? 'suggestions_and_complaints'.tr
                              : homeController.currentPageIndex == 5
                                  ? 'about_as'.tr
                                  : 'maknoon'.tr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800),
              textScaleFactor: SizeConfig.textScaleFactor,
            ),
            titleSpacing: 2,
            centerTitle: true,
            actions: [
              homeController.currentPageIndex == 3 && homeController.isWorkLocal
                  ? IconButton(
                      onPressed: (() async {
                        bool result = await CostomDailogs.yesNoDialogWithText(
                            text:
                                'all_data_will_be_updated_and_all_unreleased_operations_will_be_cancelled'
                                    .tr);
                        if (result) {
                          DataSyncController dataSyncController =
                              Get.find<DataSyncController>();
                         await dataSyncController.setIsWorkLocal(false);
                         await dataSyncController.loadDataSaveLocal();
                         await dataSyncController.loadChangedDataLocal(isInit: false);
                        }
                      }),
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          backgroundColor: Colors.white,
          drawer: Drawer(
              backgroundColor: Get.theme.primaryColor,
              child: SafeArea(
                child: Stack(
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/maknoon_icon.svg',
                              height: 100.h,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
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
                                  size: 40,
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              homeController.userLogin?.displayName ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                              textScaleFactor: SizeConfig.textScaleFactor,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Divider(
                                color: Colors.white,
                                indent: 20.w,
                                endIndent: 20.w),
                            SizedBox(
                              height: 20.h,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.menu_open,
                                color: Colors.white,
                              ),
                              title: Text(
                                'episode_list'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              onTap: () {
                                homeController.currentPageIndex = 1;
                                Get.back();
                                // Get.to(() => const GlossaryOfTerms());
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              title: Text(
                                'notifications'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              onTap: () {
                                homeController.currentPageIndex = 2;
                                Get.back();
                                // Get.to(() => const GlossaryOfTerms());
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.sync_alt_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                'synchronization'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              onTap: () {
                                homeController.currentPageIndex = 3;
                                Get.back();
                                // Get.to(() => const GlossaryOfTerms());
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                              title: Text(
                                'suggestions_and_complaints'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              onTap: () {
                                homeController.currentPageIndex = 4;
                                Get.back();
                                // Get.to(() => const GlossaryOfTerms());
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              title: Text(
                                'about_as'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              onTap: () {
                                homeController.currentPageIndex = 5;
                                Get.back();
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              title: Text(
                                'logout'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: SizeConfig.textScaleFactor,
                              ),
                              onTap: () async {
                                Get.back();
                                bool result =
                                    await CostomDailogs.yesNoDialogWithText(
                                        text: 'do_you_want_to_logout'.tr);
                                if (result) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove('userName');
                                  await prefs.remove('password');
                                  await FirebaseMessaging.instance
                                      .unsubscribeFromTopic(
                                          'teacher_${homeController.userLogin!.teachId}');
                                  await UserService().removeUserLocal();
                                  Get.off(() => const LoginIn());
                                }

                                // Get.to(() => const GlossaryOfTerms());
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              )),
          body: SafeArea(
              child: OrientationBuilder(builder: (context, orientation) {
            SizeConfig('initialSize')
                .init(originalWidth: 428, originalHeight: 926);
            return Stack(children: [
              Positioned.fill(
                child: Image.asset(
                  'images/bgR2.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              Positioned.fill(
                  child: homeController.currentPageIndex == 1
                      ? const Episodes(): homeController.currentPageIndex == 2
                          ? const Notifications()
                          : homeController.currentPageIndex == 3
                              ? const DataSync()
                              : homeController.currentPageIndex == 4
                                  ? const Complaints()
                                  : const AboutUs()),
            ]);
          }))),
    );
  }
}
