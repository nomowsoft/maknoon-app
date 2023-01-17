import 'package:shared_preferences/shared_preferences.dart';
class DataSyncService {

   Future<bool> get getIsWorkLocal async {
    final prefs = await SharedPreferences.getInstance();
   return prefs.getBool('is_work_local') ?? false;
  }

  Future setIsWorkLocal(bool isWorkLocal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_work_local',isWorkLocal);
  }
}