class Episode {
  String displayName;
  int id;
  String name, epsdType, epsdWork;

  Episode(
      {required this.displayName,
      required this.id,
      required this.name,
      required this.epsdType,
      required this.epsdWork});

  Episode.fromJson(Map<String, dynamic> json)
      : displayName = json['display_name'] ?? '',
        epsdType = json['epsd_type'] is bool ? '' : json['epsd_type']  ?? '' ,
        epsdWork =  json['epsd_work'] is bool ? '':json['epsd_work'] ?? '',
        id = json['id'] ?? 0,
        name = json['name'] ?? '';
  Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
        "epsd_type": epsdType,
        "epsd_work": epsdWork,
        "name": name,
      };
}
