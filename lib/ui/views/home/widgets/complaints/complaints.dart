import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/utils/validator.dart';
import 'package:maknoon/ui/shared/utils/waitting_dialog.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  late TextEditingController subject;
  late TextEditingController details;
  bool isValid = true;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    subject = TextEditingController(text: '');
    details = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Form(
          key: formKey,
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'subject_of_complaint'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: SizeConfig.textScaleFactor,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.light,
                        validator:
                            isValid ? Validator.subjectOfComplaint : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: subject,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 16.0.w),
                          hintText: 'enter_subject'.tr,
                        ),
                        onChanged: (val) {
                          setState(() {
                            isValid = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'complaint_details'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: SizeConfig.textScaleFactor,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.light,
                        validator:
                            isValid ? Validator.detailsOfComplaint : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: details,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 10,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 16.0.w),
                          hintText: 'enter_details'.tr,
                        ),
                        onChanged: (val) {
                          setState(() {
                            isValid = true;
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
                  child: InkWell(
                    onTap: () async {
                      if (!isValid) {
                        setState(() {
                          isValid = true;
                        });
                      } else {
                        if (formKey.currentState!.validate()) {
                          ResponseContent addComplaintsResponse =
                              await showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    addComplaints();
                                    return WillPopScope(
                                      onWillPop: () async {
                                        return false;
                                      },
                                      child: const CupertinoAlertDialog(
                                        content: WaitingDialog(),
                                      ),
                                    );
                                  });

                          if (addComplaintsResponse.isSuccess ||
                              addComplaintsResponse.isNoContent) {
                          } else {
                            CostomDailogs.snackBar(
                                response: addComplaintsResponse);
                          }
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Get.theme.secondaryHeaderColor.withOpacity(.7),
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
                          'submit'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textScaleFactor: SizeConfig.textScaleFactor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void addComplaints() async {
    HomeController homeController = Get.find<HomeController>();
    ResponseContent responseContent =
        await homeController.addComplaints(subject.text, details.text);
    if (responseContent.isSuccess || responseContent.isNoContent) {
      setState(() {
        subject = TextEditingController(text: '');
        details = TextEditingController(text: '');
        isValid = false;
      });
    }
    Get.back(result: responseContent);
  }
}
