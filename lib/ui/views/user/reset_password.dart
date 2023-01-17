import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/model/services/auth_service.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/widgets/custom_app_bar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool islogin = false;
  bool hasWaitAnim = false;
  bool loginErorr = false;
  double opacityLogin = 1.0;
  bool erorrName = false;
  String massageErorr = '';
  bool isopen = true;
  late TextEditingController name;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    name = TextEditingController();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        isopen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: 'reset_password'.tr,
            leading: IconButton(
                onPressed: (() {
                  Get.back();
                }),
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 35.sp,
                ))),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'images/bgR2.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              // Positioned.fill(
              //   child: Column(mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       IconButton(
              //       onPressed: (() {
              //         Get.back();
              //       }),
              //       icon: Icon(
              //         Icons.keyboard_arrow_right,
              //         color: Colors.black,
              //         size: 35.sp,
              //       ),
              // ),
              //     ],
              //   ),
              // ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Builder(builder: (context) {
                        SizeConfig('initialSize')
                            .init(originalWidth: 428, originalHeight: 926);
                        if (!isTablet) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            opacity: isopen ? 0.0 : 1.0,
                                            child: SvgPicture.asset(
                                              'images/maknoon_icon.svg',
                                              height: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.landscape
                                                  ? 200.h
                                                  : 150.h,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                  ),

                                  /// email
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'identification_number_location'.tr,
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
                                      TextFormField(
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.phone,
                                        keyboardAppearance: Brightness.light,
                                        onChanged: (val) {
                                          setState(() {
                                            setState(() {
                                              erorrName = false;
                                              massageErorr = '';
                                            });
                                          });
                                        },
                                        controller: name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: erorrName
                                                    ? Colors.red
                                                    : const Color(0xffD0D2DA)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: erorrName
                                                    ? Colors.red
                                                    : const Color(0xff4B1360)),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText:
                                              'enter_identification_number_location'
                                                  .tr,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: erorrName
                                                  ? Text(
                                                      massageErorr,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textScaleFactor:
                                                          SizeConfig
                                                              .textScaleFactor,
                                                    )
                                                  : const SizedBox(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap: (() async {
                                          if (!erorrName &&
                                              name.text.isNotEmpty) {
                                            setState(() {
                                              islogin = true;
                                              loginErorr = false;
                                              hasWaitAnim = false;
                                              opacityLogin = 0.0;
                                            });
                                            ResponseContent responseContent =
                                                await login();
                                            if (responseContent.isSuccess) {
                                              setState(() {
                                                hasWaitAnim = true;
                                                loginErorr = false;
                                              });
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                setState(() {
                                                  islogin = false;
                                                  opacityLogin = 1.0;
                                                  hasWaitAnim = false;
                                                });
                                              });
                                              // show sacecs
                                              CostomDailogs
                                                  .warringDialogWithGet(
                                                      msg:
                                                          'your_new_password_ok'
                                                              .tr);
                                            } else {
                                              setState(() {
                                                hasWaitAnim = true;
                                                loginErorr = true;
                                              });
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                setState(() {
                                                  islogin = false;
                                                  opacityLogin = 1.0;
                                                  hasWaitAnim = false;
                                                });
                                              });
                                              if (!responseContent
                                                  .isErrorConnection) {
                                                setState(() {
                                                  erorrName = true;
                                                  massageErorr =
                                                      responseContent.message ??
                                                          'error Rest Password';
                                                });
                                              } else {
                                                setState(() {
                                                  erorrName = false;
                                                });
                                                CostomDailogs.snackBar(
                                                    response: responseContent);
                                              }
                                            }
                                          } else {
                                            if (name.text.isEmpty) {
                                              setState(() {
                                                erorrName = true;
                                                massageErorr =
                                                    'enter_identification_number_location'
                                                        .tr;
                                              });
                                            }
                                          }
                                        }),
                                        child: AnimatedContainer(
                                          width: islogin ? 45 : Get.size.width,
                                          height: 45,
                                          curve: Curves.fastOutSlowIn,
                                          duration:
                                              const Duration(milliseconds: 700),
                                          // padding: EdgeInsets.symmetric(
                                          //     horizontal: 10.w,
                                          //     vertical: 15.h),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Get.theme.secondaryHeaderColor
                                                    .withOpacity(.7),
                                                Get.theme.secondaryHeaderColor,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                islogin ? 70 : 14),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(5, 5),
                                                blurRadius: 10,
                                              )
                                            ],
                                          ),
                                          child: Center(
                                            child: AnimatedOpacity(
                                              duration:
                                                  const Duration(seconds: 1),
                                              opacity: opacityLogin,
                                              child: Text(
                                                'reset_password'.tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textScaleFactor:
                                                    SizeConfig.textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        width: islogin ? 45 : 45,
                                        height: 45,
                                        curve: Curves.fastOutSlowIn,
                                        duration:
                                            const Duration(milliseconds: 700),
                                        // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Get.theme.secondaryHeaderColor
                                                  .withOpacity(.7),
                                              Get.theme.secondaryHeaderColor,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              islogin ? 100 : 14),
                                        ),
                                        child: Center(
                                          child: Opacity(
                                            // duration: const Duration(milliseconds: 700),
                                            opacity:
                                                opacityLogin == 0.0 ? 1.0 : 0.0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: islogin && !hasWaitAnim
                                                  ? CircularProgressIndicator(
                                                      backgroundColor: Get.theme
                                                          .secondaryHeaderColor,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              islogin
                                                                  ? Colors.white
                                                                  : Get.theme
                                                                      .secondaryHeaderColor))
                                                  : loginErorr
                                                      ? const Icon(
                                                          Icons.error_outline,
                                                          color: Colors.red,
                                                          size: 40,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .check_circle_outlined,
                                                          color: Colors.green,
                                                          size: 40,
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AnimatedOpacity(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              opacity: isopen ? 0.0 : 1.0,
                                              child: SvgPicture.asset(
                                                'images/maknoon_icon.svg',
                                                height: MediaQuery.of(context)
                                                            .orientation ==
                                                        Orientation.landscape
                                                    ? 200.h
                                                    : 150.h,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 70.h,
                                    ),

                                    ///name
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'identification_number_location'.tr,
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
                                        SizedBox(
                                          width: 400.w,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.phone,
                                            keyboardAppearance:
                                                Brightness.light,
                                            onChanged: (val) {
                                              setState(() {
                                                setState(() {
                                                  erorrName = false;
                                                  massageErorr = '';
                                                });
                                              });
                                            },
                                            controller: name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: erorrName
                                                          ? Colors.red
                                                          : const Color(
                                                              0xffD0D2DA)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: erorrName
                                                          ? Colors.red
                                                          : const Color(
                                                              0xff4B1360)),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText:
                                                    'enter_identification_number_location'
                                                        .tr,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16.0.w,
                                                        vertical: 16.0.w)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 400.w,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: erorrName
                                                      ? Text(
                                                          massageErorr,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textScaleFactor:
                                                              SizeConfig
                                                                  .textScaleFactor,
                                                        )
                                                      : const SizedBox(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    SizedBox(
                                      width: 400.w,
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            InkWell(
                                              onTap: (() async {
                                                if (!erorrName &&
                                                    name.text.isNotEmpty) {
                                                  setState(() {
                                                    islogin = true;
                                                    loginErorr = false;
                                                    hasWaitAnim = false;
                                                    opacityLogin = 0.0;
                                                  });
                                                  ResponseContent
                                                      responseContent =
                                                      await login();
                                                  if (responseContent
                                                      .isSuccess) {
                                                    setState(() {
                                                      hasWaitAnim = true;
                                                      loginErorr = false;
                                                    });
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      setState(() {
                                                        islogin = false;
                                                        opacityLogin = 1.0;
                                                        hasWaitAnim = false;
                                                      });
                                                    });
                                                    CostomDailogs
                                                        .warringDialogWithGet(
                                                            msg:
                                                                'your_new_password_ok'
                                                                    .tr);
                                                  } else {
                                                    setState(() {
                                                      hasWaitAnim = true;
                                                      loginErorr = true;
                                                    });
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      setState(() {
                                                        islogin = false;
                                                        opacityLogin = 1.0;
                                                        hasWaitAnim = false;
                                                      });
                                                    });
                                                    if (!responseContent
                                                        .isErrorConnection) {
                                                      setState(() {
                                                        erorrName = true;
                                                        massageErorr =
                                                            responseContent
                                                                    .message ??
                                                                'error Rest Password';
                                                      });
                                                    } else {
                                                      setState(() {
                                                        erorrName = false;
                                                      });
                                                      CostomDailogs.snackBar(
                                                          response:
                                                              responseContent);
                                                    }
                                                  }
                                                } else {
                                                  if (name.text.isEmpty) {
                                                    setState(() {
                                                      erorrName = true;
                                                      massageErorr =
                                                          'enter_identification_number_location'
                                                              .tr;
                                                    });
                                                  }
                                                }
                                              }),
                                              child: AnimatedContainer(
                                                width: islogin
                                                    ? 45.w
                                                    : Get.size.width,
                                                height: 45.w,
                                                curve: Curves.fastOutSlowIn,
                                                duration: const Duration(
                                                    milliseconds: 700),
                                                // padding: EdgeInsets.symmetric(
                                                //     horizontal: 10.w, vertical: 15.h),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Get.theme
                                                          .secondaryHeaderColor
                                                          .withOpacity(.7),
                                                      Get.theme
                                                          .secondaryHeaderColor,
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          islogin ? 100 : 14),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(5, 5),
                                                      blurRadius: 10,
                                                    )
                                                  ],
                                                ),
                                                child: Center(
                                                  child: AnimatedOpacity(
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    opacity: opacityLogin,
                                                    child: Text(
                                                      'reset_password'.tr,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
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
                                            AnimatedContainer(
                                              width: islogin ? 45.w : 45.w,
                                              height: 45.w,
                                              curve: Curves.fastOutSlowIn,
                                              duration: const Duration(
                                                  milliseconds: 700),
                                              // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Get.theme
                                                        .secondaryHeaderColor
                                                        .withOpacity(.7),
                                                    Get.theme
                                                        .secondaryHeaderColor,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        islogin ? 100 : 14),
                                              ),
                                              child: Center(
                                                child: Opacity(
                                                  // duration: const Duration(milliseconds: 700),
                                                  opacity: opacityLogin == 0.0
                                                      ? 1.0
                                                      : 0.0,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(1),
                                                    child: islogin &&
                                                            !hasWaitAnim
                                                        ? CircularProgressIndicator(
                                                            backgroundColor: Get
                                                                .theme
                                                                .secondaryHeaderColor,
                                                            valueColor: AlwaysStoppedAnimation<
                                                                    Color>(
                                                                islogin
                                                                    ? Colors
                                                                        .white
                                                                    : Get.theme
                                                                        .secondaryHeaderColor))
                                                        : loginErorr
                                                            ? const Icon(
                                                                Icons
                                                                    .error_outline,
                                                                color:
                                                                    Colors.red,
                                                                size: 40,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .check_circle_outlined,
                                                                color: Colors
                                                                    .green,
                                                                size: 40,
                                                              ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future login() async {
    ResponseContent response = await AuthService().resetPassword(name.text);
    return response;
  }
}
