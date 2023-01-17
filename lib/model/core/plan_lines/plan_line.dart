import 'package:maknoon/model/core/plan_lines/mistakes_plan_line.dart';

class PlanLine {
  String fromSuraName,toSuraName;
  int fromAya,toAya,mistake,prepId;
  double degree;
  Mistakes? mistakes;

  PlanLine({required this.degree, required this.fromSuraName,required this.fromAya,required this.toAya,required this.toSuraName,required this.mistake,required this.prepId,this.mistakes});

  PlanLine.fromJson(Map<String, dynamic> json):
    fromSuraName = json['from_sura_name'] ?? '',
    toSuraName = json['to_sura_name'] ?? '',
    degree = double.tryParse(json['degree'].toString()) ?? 0,
    fromAya = json['from_aya'] ?? 0,
    toAya = json['to_aya'] ?? 0,
    prepId = json['prep_id'] ?? 0,
    mistake = json['mistake'] ?? 0;
 

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "from_sura_name": fromSuraName,
        "to_sura_name": toSuraName,
        "from_aya": fromAya,
        "to_aya": toAya,
        "prep_id": prepId,
        "mistake": mistake,
      };
}

