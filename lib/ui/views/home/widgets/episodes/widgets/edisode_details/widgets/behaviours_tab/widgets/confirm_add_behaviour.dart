import 'package:flutter/material.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart';

class ConfirmAddBehaviour extends StatefulWidget {
  const ConfirmAddBehaviour({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmAddBehaviour> createState() => _ConfirmAddBehaviourState();
}

class _ConfirmAddBehaviourState extends State<ConfirmAddBehaviour> {
  bool sendToParent = false;
  bool sendToTeacher = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'confirm'.tr,
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                    textScaleFactor: SizeConfig.textScaleFactor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'do_you_want_to_send_the_behavior'.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
                textScaleFactor: SizeConfig.textScaleFactor,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: sendToParent,
                          activeColor: Get.theme.primaryColor,
                          title: Text(
                            'inform_the_parent_of_the_behavior'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                            textScaleFactor: SizeConfig.textScaleFactor,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ), //    <-- label
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                sendToParent = value;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                       Expanded(
                        child: CheckboxListTile(
                          value: sendToTeacher,
                          activeColor: Get.theme.primaryColor,
                          title: Text(
                            'send_the_behavior_to_the_episode_moderator'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                            textScaleFactor: SizeConfig.textScaleFactor,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ), //    <-- label
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                sendToTeacher = value;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      child: Text(
                        'yes'.tr,
                        style:  TextStyle(color: Colors.white,fontSize: 14.sp),
                        textScaleFactor: SizeConfig.textScaleFactor,
                      ),
                      onPressed: () async {
                        Get.back(result: [sendToParent,sendToTeacher]);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      child: Text(
                        'no'.tr,
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14.sp),
                        textScaleFactor: SizeConfig.textScaleFactor,
                      ),
                      onPressed: () async {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
