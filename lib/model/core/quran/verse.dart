class Verse
{
  int id,originalSurahOrder,pageNo,surahId;
  String verse;

  Verse.fromJson(Map<String, dynamic> json):
    id = json['id'] ?? 0,
    verse = json['verse'] ?? '',
    originalSurahOrder = json['original_surah_order'] ?? 0,
    pageNo =json['page_no'] ?? 0,
    surahId =json['surah_id'] ?? 0;
}