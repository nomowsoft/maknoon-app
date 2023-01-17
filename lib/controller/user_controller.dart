import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/user/auth_model.dart';
import 'package:maknoon/model/services/auth_service.dart';
import 'package:maknoon/model/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../model/core/shared/response_content.dart';
import '../model/core/user/sgin_in.dart';

class UserController extends GetxController {
  late TextEditingController name;
  late TextEditingController password;
  AuthModel? _userLogin;
  AuthModel? get userLogin => _userLogin;
  bool _gettingData = true;
  set gettingData(bool val) => {_gettingData = val, update()};
  bool get gettingData => _gettingData;

  @override
  Future onInit() async {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    initFields();
   // await getUser();
  }

  initFields() {
    name = TextEditingController();
    password = TextEditingController();
    _gettingData = false;
  }
  
  

  Future userLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _userLogin = null;
    update();
  }

  Future<ResponseContent> postSignIn({bool isLoginPassword = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     SignIn user ;
    if (isLoginPassword) {
     user = SignIn(
      password: password.text.trim(),
      userName: name.text.trim(),
    );
    }else{
      user = SignIn(
      userName: prefs.getString('userName') ?? '',
      password: prefs.getString('password') ?? '',
    );
    }
    ResponseContent response = await AuthService().postSignIn(user);
    if (response.isSuccess) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isLoginPassword) {
          await prefs.setString('userName', name.text.trim().toString());
          await prefs.setString('password', password.text.trim().toString());
    }
    AuthModel? userLogin =await UserService().getUserLocal;
    if(userLogin !=null){
      await FirebaseMessaging.instance.subscribeToTopic('teacher_${userLogin.teachId}');
      }
    }
    update();
    return response;
  }
}
