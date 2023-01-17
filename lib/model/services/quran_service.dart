import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maknoon/model/core/quran/surah.dart';
import 'package:maknoon/model/core/quran/verse.dart';
import 'package:maknoon/model/core/shared/constants.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart';

class QuranService {
  getVerses(
      {required String fromSurah,
      required int fromAya,
      required String toSurah,
      required int toAya}) {
    try {
      int indexFromSurah = Constants.listSurah
          .indexWhere((element) => element.name == fromSurah);
      int indexToSurah =
          Constants.listSurah.indexWhere((element) => element.name == toSurah);
      List<Surah> listSurah = Constants.listSurah
          .skip(indexFromSurah)
          .take((indexToSurah + 1) - (indexFromSurah))
          .toList();
      List<Verse> listVerses = Constants.listVerse
          .where((element) =>
              listSurah.map((e) => e.id).toList().contains(element.surahId))
          .toList();
      listVerses.sort((a, b) {
        var compare = a.surahId.compareTo(b.surahId);
        if (compare == 0) {
          return a.originalSurahOrder.compareTo(b.originalSurahOrder);
        } else {
          return compare;
        }
      });
      int indexFromAya = listVerses
          .indexWhere((element) => element.originalSurahOrder == fromAya);
      int indexToAya = listVerses.indexWhere((element) =>
          element.surahId == listVerses.last.surahId &&
          element.originalSurahOrder == toAya);
      return listVerses
          .skip(indexFromAya)
          .take((indexToAya + 1) - indexFromAya)
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String getSurahNane(int surahId) {
    try {
      return Constants.listSurah
          .firstWhere((element) => element.id == surahId)
          .name;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return '';
    }
  }

  List<TextSpan> getVersesTextSpan(List<Verse> dataVerses) {
    List<TextSpan> verses = [];

    for (var element in dataVerses) {
      if (element.id != 0) {
        verses.add(TextSpan(
          text: element.verse
              .replaceAll('بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', ''),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            //fontFamily: 'UthmanicDoori',
            fontSize: 24.sp,
          ),
        ));
        verses.add(TextSpan(
          text: ' ﴿ ${element.originalSurahOrder} ﴾ ',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Get.theme.primaryColor,
            //fontFamily: 'UthmanicDoori',
            fontSize: 20.sp,
          ),
        ));
      }
    }
    return verses;
  }
}
