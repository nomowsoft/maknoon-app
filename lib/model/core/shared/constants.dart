

import 'package:maknoon/model/core/quran/surah.dart';
import 'package:maknoon/model/core/quran/verse.dart';
import 'package:maknoon/model/offline_quran/surahs.dart';
import 'package:maknoon/model/offline_quran/verses.dart';

class Constants {
static late List<Surah> listSurah;
static late List<Verse> listVerse;
getConstants(){
  listSurah = surahs.map((e) => Surah.fromJson(e)).toList(); 
  listVerse = verses.map((e) => Verse.fromJson(e)).toList(); 
}
}


