class CalendarCenter {
  String name,centerName,placeOptions,date;
  int id,centerId;

  CalendarCenter({required this.centerName,required this.centerId,required this.id,required this.name,required this.placeOptions,required this.date});

  CalendarCenter.fromJson(Map<String, dynamic> json):
    centerName = json['center_name'] ?? '',
    placeOptions = json['place_options'] ?? '',
    date = json['date'] ?? '',
    id = json['id'] ?? 0,
    centerId = json['center_id'] ?? 0,
    name = json['name'] ?? '';

  Map<String, dynamic> toMap() => {
        "id": id,
        "center_id": centerId,
        "center_name": centerName,
        "place_options": placeOptions,
        "date": date,
        "name": name
      };
}