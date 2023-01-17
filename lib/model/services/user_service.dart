import 'package:maknoon/model/core/user/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class UserService {

  Future<AuthModel?> get getUserLocal async {
    final prefs = await SharedPreferences.getInstance();
    String files = prefs.getString('user_login') ?? '';
    var data = files.isNotEmpty ? convert.jsonDecode(files) : null;
    if (data != null) {
      return AuthModel.fromJson(data);
    }
    return null;
  }

  Future setUserLocal(AuthModel authModel) async {
    final prefs = await SharedPreferences.getInstance();
    final listJson = authModel.toJson();
    var data = convert.jsonEncode(listJson);
    await prefs.setString('user_login', data.toString());
  }

  Future removeUserLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_login', '');
  }
}
