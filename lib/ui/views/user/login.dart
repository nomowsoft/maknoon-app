import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maknoon/controller/user_controller.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/core/shared/response_content.dart';
import 'package:maknoon/ui/shared/utils/custom_dailogs.dart';
import 'package:maknoon/ui/shared/utils/validator.dart';
import 'package:maknoon/ui/views/data_initialization/data_initialization.dart';
import 'package:maknoon/ui/views/user/reset_password.dart';

class LoginIn extends StatefulWidget {
  const LoginIn({Key? key}) : super(key: key);

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  bool islogin = false;
  bool hasWaitAnim = false;
  bool loginErorr = false;
  double opacityLogin = 1.0;
  bool erorrPassword = false;
  String massageErorr = '';
  bool isopen = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    UserController userController = Get.put(UserController());
    userController.initFields();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        isopen = false;
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (UserController userController) => Scaffold(
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
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Builder(builder: (context) {
                        SizeConfig('initialSize').init(originalWidth: 428, originalHeight: 926);
                        if (!isTablet) {
                          return SingleChildScrollView(
                            child: Form(
                              key: formKey, 
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

                                    /// email
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
                                        TextFormField(
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.phone,
                                          keyboardAppearance: Brightness.light,
                                          validator: Validator
                                              .identificationNumberLocation,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: userController.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText:
                                                'enter_identification_number_location'
                                                    .tr,
                                          ),
                                          onChanged: (val) {},
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),

                                    ///passworf
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'password'.tr,
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
                                          keyboardType: TextInputType.text,
                                          keyboardAppearance: Brightness.light,
                                          onChanged: (val) {
                                            setState(() {
                                              setState(() {
                                                erorrPassword = false;
                                                massageErorr = '';
                                              });
                                            });
                                          },
                                          //validator: Validator.passwordValidator,
                                          //autovalidateMode: AutovalidateMode.onUserInteraction,
                                          //obscureText: passwordObscure,
                                          controller: userController.password,
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
                                                  color: erorrPassword
                                                      ? Colors.red
                                                      : const Color(
                                                          0xffD0D2DA)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: erorrPassword
                                                      ? Colors.red
                                                      : const Color(
                                                          0xff4B1360)),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'enter_password'.tr,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 5.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: erorrPassword
                                                    ? Text(
                                                        massageErorr,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        textScaleFactor:
                                                            SizeConfig
                                                                .textScaleFactor,
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(() =>const ResetPassword(),
                                                      duration:
                                                          const Duration(milliseconds: 700),
                                                      curve: Curves.easeInOut,
                                                      transition: Transition.fadeIn);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 5.h),
                                                  child: Text(
                                                    'forgot_password'.tr,
                                                    style: TextStyle(
                                                        color: Get
                                                            .theme.primaryColor,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    textScaleFactor: SizeConfig
                                                        .textScaleFactor,
                                                  ),
                                                ),
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
                                            if (formKey.currentState!
                                                    .validate() &&
                                                !erorrPassword &&
                                                userController
                                                    .password.text.isNotEmpty) {
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
                                                // Get.put(HomeController()).getUserLocal();
                                                Get.off(() => const DataInitialization(),
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve: Curves.easeInOut,
                                                    transition:
                                                        Transition.fadeIn);
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
                                                    erorrPassword = true;
                                                    massageErorr =
                                                        responseContent
                                                                .message ??
                                                            'error login';
                                                  });
                                                } else {
                                                  setState(() {
                                                    erorrPassword = false;
                                                  });
                                                  CostomDailogs.snackBar(
                                                      response:
                                                          responseContent);
                                                }
                                              }
                                            } else {
                                              if (userController
                                                  .password.text.isEmpty) {
                                                setState(() {
                                                  erorrPassword = true;
                                                  massageErorr =
                                                      'enter_password'.tr;
                                                });
                                              }
                                            }
                                          }),
                                          child: AnimatedContainer(
                                            width: islogin
                                                ? 45
                                                : Get.size.width,
                                            height: 45,
                                            curve: Curves.fastOutSlowIn,
                                            duration: const Duration(
                                                milliseconds: 700),
                                            // padding: EdgeInsets.symmetric(
                                            //     horizontal: 10.w,
                                            //     vertical: 15.h),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Get.theme.secondaryHeaderColor
                                                      .withOpacity(.7),
                                                  Get.theme
                                                      .secondaryHeaderColor,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                  'sign_in'.tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textScaleFactor: SizeConfig
                                                      .textScaleFactor,
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
                                              opacity: opacityLogin == 0.0
                                                  ? 1.0
                                                  : 0.0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: islogin && !hasWaitAnim
                                                    ? CircularProgressIndicator(
                                                        backgroundColor: Get
                                                            .theme
                                                            .secondaryHeaderColor,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                islogin
                                                                    ? Colors
                                                                        .white
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
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: Center(
                              child: Form(
                                key: formKey,
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

                                      /// email
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
                                                  TextInputAction.next,
                                              keyboardType: TextInputType.phone,
                                              keyboardAppearance:
                                                  Brightness.light,
                                              validator: Validator
                                                  .identificationNumberLocation,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: userController.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                       EdgeInsets.symmetric(
                                                          horizontal: 16.0.w,
                                                          vertical: 16.0.w),
                                                hintText:
                                                    'enter_identification_number_location'
                                                        .tr,
                                              ),
                                              onChanged: (val) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      ///passworf
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'password'.tr,
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
                                              keyboardType: TextInputType.text,
                                              keyboardAppearance:
                                                  Brightness.light,
                                              onChanged: (val) {
                                                setState(() {
                                                  setState(() {
                                                    erorrPassword = false;
                                                    massageErorr = '';
                                                  });
                                                });
                                              },
                                              //validator: Validator.passwordValidator,
                                              //autovalidateMode: AutovalidateMode.onUserInteraction,
                                              //obscureText: passwordObscure,
                                              controller: userController.password,
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
                                                        color: erorrPassword
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
                                                        color: erorrPassword
                                                            ? Colors.red
                                                            : const Color(
                                                                0xff4B1360)),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  hintText: 'enter_password'.tr,
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
                                                  vertical: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: erorrPassword
                                                        ? Text(
                                                            massageErorr,
                                                            style: TextStyle(
                                                                color: Colors.red,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            textScaleFactor:
                                                                SizeConfig
                                                                    .textScaleFactor,
                                                          )
                                                        : const SizedBox(),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(() =>const ResetPassword(),
                                                          duration:
                                                              const Duration(milliseconds: 700),
                                                          curve: Curves.easeInOut,
                                                          transition: Transition.fadeIn);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 5.h),
                                                      child: Text(
                                                        'forgot_password'.tr,
                                                        style: TextStyle(
                                                            color: Get.theme
                                                                .primaryColor,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                        textScaleFactor:
                                                            SizeConfig
                                                                .textScaleFactor,
                                                      ),
                                                    ),
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
                                                  if (formKey.currentState!
                                                          .validate() &&
                                                      !erorrPassword &&
                                                      userController.password.text
                                                          .isNotEmpty) {
                                                    setState(() {
                                                      islogin = true;
                                                      loginErorr = false;
                                                      hasWaitAnim = false;
                                                      opacityLogin = 0.0;
                                                    });
                                                    ResponseContent
                                                        responseContent =
                                                        await login();
                                                    if (responseContent.isSuccess) {
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
                                                      // Get.put(HomeController()).getUserLocal();
                                                      Get.off(() => const DataInitialization(),
                                                          duration: const Duration(
                                                              seconds: 1),
                                                          curve: Curves.easeInOut,
                                                          transition:
                                                              Transition.fadeIn );
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
                                                          erorrPassword = true;
                                                          massageErorr =
                                                              responseContent
                                                                      .message ??
                                                                  'error login';
                                                        });
                                                      } else {
                                                        setState(() {
                                                          erorrPassword = false;
                                                        });
                                                        CostomDailogs.snackBar(
                                                            response:
                                                                responseContent);
                                                      }
                                                    }
                                                  } else {
                                                    if (userController
                                                        .password.text.isEmpty) {
                                                      setState(() {
                                                        erorrPassword = true;
                                                        massageErorr =
                                                            'enter_password'.tr;
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
                                                        'sign_in'.tr,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textScaleFactor: SizeConfig
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
                                                      Get.theme.secondaryHeaderColor
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
                                                      child: islogin && !hasWaitAnim
                                                          ? CircularProgressIndicator(
                                                              backgroundColor: Get
                                                                  .theme
                                                                  .secondaryHeaderColor,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      islogin
                                                                          ? Colors
                                                                              .white
                                                                          : Get
                                                                              .theme
                                                                              .secondaryHeaderColor))
                                                          : loginErorr
                                                              ? const Icon(
                                                                  Icons
                                                                      .error_outline,
                                                                  color: Colors.red,
                                                                  size: 40,
                                                                )
                                                              : const Icon(
                                                                  Icons
                                                                      .check_circle_outlined,
                                                                  color:
                                                                      Colors.green,
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
        ),
      ),
    );
  }

  Future login({bool isLoginPassword = true}) async {
    UserController userController = Get.find<UserController>();
    ResponseContent response =
        await userController.postSignIn(isLoginPassword: isLoginPassword);
    return response;
  }
}
